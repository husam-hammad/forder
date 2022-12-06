// ignore_for_file: avoid_print

import 'package:connectivity/connectivity.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/textstyles.dart';

class ConnectivityController extends GetxController {
  var connectResult = ConnectivityResult.none;
  bool connected = false;
  bool wasNoConnection = false;
  @override
  void onInit() async {
    super.onInit();
    connectResult = await (Connectivity().checkConnectivity());
    if (connectResult == ConnectivityResult.none) {
      connected = false;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectResult = result;

      update();
      if (result == ConnectivityResult.none) {
        wasNoConnection = true;
        connected = false;
        update();
        Get.rawSnackbar(
          duration: const Duration(seconds: 20),
          messageText: Text(
            "noconnection".tr,
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: Colors.redAccent,
        );
      } else {
        if (wasNoConnection == true) {
          Get.closeAllSnackbars();
          Get.rawSnackbar(
            duration: const Duration(seconds: 2),
            messageText: const Text(
              "متصل بالانترنت",
              textAlign: TextAlign.center,
              style: AppTextStyles.whiteRegularHeading,
            ),
            backgroundColor: AppColors.green,
          );
          wasNoConnection = false;
        }
        connected = true;
        update();
      }
    });
  }
}
