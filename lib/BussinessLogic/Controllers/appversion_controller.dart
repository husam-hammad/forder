// ignore_for_file: avoid_print

import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/main.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

class AppversionController extends GetxController {
  String appversion = MyApp.appVersion;
  AppUpdateInfo? updateInfo;
  bool flexibleUpdateAvailable = false;

  @override
  void onInit() async {
    await checkForUpdate();
    super.onInit();
  }

  Future<void> checkForUpdate() async {

    InAppUpdate.checkForUpdate().then((info) {
      updateInfo = info;

      update();
    });
    if (updateInfo !=
            null /*  &&
        updateInfo!.updateAvailability == UpdateAvailability.updateAvailable */
        ) {
      if (MyApp.settingMandatoryUpdate) {
        Get.offAndToNamed(AppRoutes.appversion);
      }
    }
  }

  Future<void> immediateUpdate() async {
    await InAppUpdate.performImmediateUpdate().then((value) => print(value));
  }
}
