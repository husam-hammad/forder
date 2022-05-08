// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/Presenttion/Screens/Auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  bool sendbuttonEnable = true;
  final phonecontroller = TextEditingController();
  final HomeController homeController = Get.find();
  final box = GetStorage();
  final String otpcode = "55555";
  UserClient userClient = UserClient();
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
    if (phonecontroller.value.text.length != 10) {
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

  Future<void> registerUser(phone) async {
    User? user = await userClient.register(phone, phone);

    if (user != null) {
      box.write('userdata', user.toMap());
    } else {
      print("there is no user ");
    }
    homeController.updateFCM();
  }

  Future<void> saveAuth() async {
    box.write("authed", true);
  }

  Future<void> checkOTP(String otp) async {
    if (otp == otpcode) {
      await saveAuth();
      await registerUser(phonecontroller.value.text);
      Get.toNamed(AppRoutes.homepage);
    } else {
      Get.snackbar("", "يرجى التأكد من وصول الرمز",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
