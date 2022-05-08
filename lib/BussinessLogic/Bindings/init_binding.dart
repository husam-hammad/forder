import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:get/get.dart';
import 'package:flashorder/BussinessLogic/Controllers/fcm_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/appbar_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
    Get.put<FCMController>(FCMController());
    Get.put<AppBarController>(AppBarController());
    Get.put<HomeController>(HomeController());
  }
}
