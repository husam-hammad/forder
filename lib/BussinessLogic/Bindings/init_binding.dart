import 'package:flashorder/BussinessLogic/Controllers/appbar_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/connectivity_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/fcm_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:get/get.dart';

import '../Controllers/home_controller.dart';
import '../Controllers/restaurent_controller.dart';
import '../Controllers/splash_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController());
    Get.put<SplashController>(SplashController());
    Get.put<UserController>(UserController());
    Get.put<SettingsController>(SettingsController());
    Get.put<FCMController>(FCMController());
    Get.put<AppBarController>(AppBarController());

    Get.put<PlacesController>(PlacesController());
    Get.put<HomeController>(HomeController());
    Get.put<RestaurentController>(RestaurentController());
/*     Get.put<AppversionController>(AppversionController()); */
  }
}
