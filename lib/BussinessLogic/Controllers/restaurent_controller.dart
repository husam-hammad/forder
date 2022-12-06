// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/restaurent_repo.dart';
import 'package:flashorder/helpers/calc.dart';
import 'package:flashorder/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class RestaurentController extends GetxController {
  final HomeController homeController = Get.find();
  final SettingsController settingsController = Get.find();
  late RestaurentRepo repo;
  List<Restaurent> restaurents = [];
  List<Restaurent> nearestrestaurents = [];
  bool homeRestaurentsLoaded = false;
  var selectedindex = 0.obs;
  late Position? position;
  List<Restaurent> oppenedRestaurents = [];
  List<Restaurent> allrestaurents = [];
  var oppenedRestaurentToggled = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await getResturents();
  }

  Future<void> getResturents() async {
    repo = RestaurentRepo(RestaurentClient());
    await repo.getall().then((data) {
      restaurents = data;
      oppenedRestaurents =
          restaurents.where((element) => element.isOpen == 1).toList();
      allrestaurents = restaurents;
    });

    position = await homeController.determinePosition();
    MyApp.userPosition = position;
    if (position != null) {
      for (var restaurent in restaurents) {
        restaurent.getDeliveryCost();
      }
      restaurents.sort(((a, b) => a.distance.compareTo(b.distance)));
    }

    //homeRestaurentsLoaded = true;
    update();
  }

  void toggleOppened() {
    if (oppenedRestaurentToggled.value) {
      restaurents = allrestaurents;
      oppenedRestaurentToggled.value = false;
      update();
    } else {
      restaurents = oppenedRestaurents;
      oppenedRestaurentToggled.value = true;
      update();
    }
    update();
  }

  Future<void> getNearest() async {
    repo = RestaurentRepo(RestaurentClient());
    position = await homeController.determinePosition();
    MyApp.userPosition = position;

    if (position != null) {
      await repo
          .getNearest(position!.latitude, position!.longitude)
          .then((data) {
        nearestrestaurents = data;
      });
      for (var restaurent in nearestrestaurents) {
        restaurent.getDeliveryCost();
      }
    } else {}
    homeRestaurentsLoaded = true;
    update();
  }

  //nearestrestaurents

  Future<void> setDeliveryCost(Restaurent restaurent) async {
    try {
      double distance = Calc.calculateDistance(restaurent.lat, restaurent.long,
          position!.latitude, position!.longitude);
      num cost = Calc.deliveryCost(distance, settingsController.perKmCost);
      restaurent.deliveryCost = cost;
      restaurent.distance = distance;
    } catch (e) {
      print(e);
    }
  }

  Restaurent? restaunretFromId(int id) {
    var result =
        restaurents.where((element) => element.id.isEqual(id)).toList();
    if (result.isNotEmpty) {
      return result[0];
    } else {
      return null;
    }
  }

  @override
  void onReady() async {
    await getNearest();
    super.onReady();
  }
}
