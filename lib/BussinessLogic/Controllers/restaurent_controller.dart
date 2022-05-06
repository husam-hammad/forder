// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/restaurent_repo.dart';
import 'package:flashorder/helpers/calc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class RestaurentController extends GetxController {
  final HomeController homeController = Get.find();
  final SettingsController settingsController = Get.find();
  late RestaurentRepo repo;
  List<Restaurent> restaurents = [];
  bool homeRestaurentsLoaded = false;
  var selectedindex = 0.obs;
  late Position position;

  @override
  void onInit() async {
    super.onInit();
    await getResturents();
    /* print(restaurents.map((e) => e.id.toString())); */
  }

  Future getResturents() async {
    repo = RestaurentRepo(RestaurentClient());
    await repo.getall().then((data) {
      restaurents = data;
    });
    position = await homeController.determinePosition();
    for (var restaurent in restaurents) {
      restaurent.getDeliveryCost();
    }
    homeRestaurentsLoaded = true;
    update();
  }

  Future<void> setDeliveryCost(Restaurent restaurent) async {
    double distance = Calc.calculateDistance(
        restaurent.lat, restaurent.long, position.latitude, position.longitude);
    num cost = Calc.deliveryCost(distance, settingsController.perKmCost);
/*     print("cost of : " + restaurent.name + cost.toString()); */
    restaurent.deliveryCost = cost;
  }

  Restaurent? restaunretFromId(int id) {
    var result =
        restaurents.where((element) => element.id.isEqual(id)).toList();
    if (result.isNotEmpty) {
      print("from Id " + result[0].id.toString());
      return result[0];
    } else {
      print("No Resturent result Is Empty");
      return null;
    }
  }
}
