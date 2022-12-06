// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:get/get.dart';

import '../../DataAccess/Models/restaurent.dart';
import '../../Presenttion/Screens/restaurent_screen.dart';

class AdvertiseController extends GetxController {
  late RestaurentController restaurentController;

  @override
  void onInit() async {
    super.onInit();
    if (Get.parameters["showrestaurent"].toString() == "1") {
      if (!Get.isRegistered<RestaurentController>()) {
        restaurentController = Get.put(RestaurentController());
      } else {
        restaurentController = Get.find();
      }
      if (restaurentController.restaurents.isEmpty) {
        await restaurentController.getResturents();
      }
    }
  }

  @override
  void onReady() async {
    super.onReady();
    if (Get.parameters["showads"] == "1") {
      print("showads");

      await Get.defaultDialog(
          title: Get.parameters["title"]!,
          middleText: Get.parameters["message"]!);
    } else {
      Restaurent? restaurent = restaurentController
          .restaunretFromId(int.parse(Get.parameters["id"].toString()));
      print("going to restaurent");
      if (restaurent != null) {
        Get.to(RestaurentScreen(restaurent: restaurent));
      }
    }
  }
}
