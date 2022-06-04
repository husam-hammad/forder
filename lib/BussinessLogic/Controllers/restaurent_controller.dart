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
  bool homeRestaurentsLoaded = false;
  var selectedindex = 0.obs;
  late Position? position;

  @override
  void onInit() async {
    super.onInit();
    await getResturents();
  }

  Future getResturents() async {
    repo = RestaurentRepo(RestaurentClient());
    await repo.getall().then((data) {
      restaurents = data;
    });
    position = await homeController.determinePosition();
    MyApp.userPosition = position;
    if (position != null) {
      print(position);
      for (var restaurent in restaurents) {
        restaurent.getDeliveryCost();
      }
    }

    homeRestaurentsLoaded = true;
    update();
  }

  Future<void> setDeliveryCost(Restaurent restaurent) async {
    double distance = Calc.calculateDistance(restaurent.lat, restaurent.long,
        position!.latitude, position!.longitude);
    num cost = Calc.deliveryCost(distance, settingsController.perKmCost);
    restaurent.deliveryCost = cost;
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
}
