// ignore_for_file: avoid_print

import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/Presenttion/Screens/Auth/otp.dart';
import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  bool sendbuttonEnable = true;
  final textcontroller = TextEditingController();
  final box = GetStorage();
  final String otpcode = "55555";

  Future<bool> checkAuth() async {
    bool authed = box.read('authed') ?? false;
    print('authed' + authed.toString());
    if (authed == true) {
      return true;
    }
    return false;
  }

  Future<void> sendMessage() async {
    sendbuttonEnable = false;
    if (textcontroller.value.text.length != 10) {
      Get.snackbar("", "يرجى إدخال رقم من 10 مراتب",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM,
          padding: EdgeInsets.zero);
    } else {
      Get.to(const OtpScreen());
    }
  }

  Future<User?> registerUser() async {
    return null;
  }

  Future<void> saveAuth() async {
    box.write("authed", true);
  }

  Future<void> checkOTP(String otp) async {
    if (otp == otpcode) {
      await saveAuth();
      Get.to(HomeScreen());
    } else {
      Get.snackbar("", "يرجى التأكد من وصول الرمز",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
