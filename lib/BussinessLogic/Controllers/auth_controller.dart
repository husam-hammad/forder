// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
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
  final optcontroller = TextEditingController();
  final HomeController homeController = Get.find();
  late UserController userController;
  final box = GetStorage();
  final String otpcode = "55555";
  UserClient userClient = UserClient();
  var loadingregister = false.obs;
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
      userController = Get.find();
      userController.user = user;
      userController.update();
    } else {
      print("there is no user ");
    }
    homeController.updateFCM();
  }

  Future<void> saveAuth() async {
    box.write("authed", true);
  }

  Future<void> checkOTP() async {
    if (optcontroller.text == otpcode) {
      loadingregister.value = true;
      await saveAuth();
      await registerUser(phonecontroller.value.text);
      loadingregister.value = false;
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
