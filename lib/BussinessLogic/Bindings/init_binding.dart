import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:get/get.dart';
import 'package:flashorder/BussinessLogic/Controllers/fcm_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/appbar_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import '../Controllers/bottomnav_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
    Get.put<SettingsController>(SettingsController());
    Get.put<NavController>(NavController());
    Get.put<FCMController>(FCMController());
    Get.put<AppBarController>(AppBarController());
    Get.put<PlacesController>(PlacesController());
    Get.put<HomeController>(HomeController());
  }
}
