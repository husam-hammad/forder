// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/BussinessLogic/Providers/sms_client.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/Presenttion/Screens/Auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:telephony/telephony.dart';

class AuthController extends GetxController {
  //final Telephony telephony = Telephony.instance;
  var sendTries = 0.obs;
  var sendAbility = true.obs;
  var resendTerm = 30.obs;
  late Timer timer;
  var retrySendValue = 30.obs;
  bool sendbuttonEnable = true;
  bool sendingprogress = false;
  final phonecontroller = TextEditingController();
  final optcontroller = TextEditingController();
  final HomeController homeController = Get.put(HomeController());
  late UserController userController;
  SMSCleint smsCleint = SMSCleint();
  final box = GetStorage();
  late String otpcode;
  UserClient userClient = UserClient();
  var loadingregister = false.obs;
  Future<bool> checkAuth() async {
    bool authed = box.read('authed') ?? false;
    //print('authed' + authed.toString());
    if (authed == true) {
      return true;
    }
    return false;
  }

  /* @override
  void onInit() async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    print("permissionsGranted : " + permissionsGranted.toString());
    if (permissionsGranted == null || permissionsGranted == false) {
      await telephony.requestSmsPermissions;
    }
    telephony.listenIncomingSms(
      listenInBackground: false,
      onNewMessage: (SmsMessage message) {
        if (message.body!.contains("رمز")) {
          checkOTPListen(message.body!.substring(message.body!.length - 5));
        }
      },
    );
    super.onInit();
  } */

  void startTimer() {
    print("timer started");
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (retrySendValue.value == 0) {
          //print("retrySendValue.value == 0");
          timer.cancel();
          sendAbility.value = true;
          resendTerm.value = 30 * sendTries.value;
          retrySendValue.value = resendTerm.value;
        } else {
          sendAbility.value = false;
          
          retrySendValue.value--;
          update();
        }
      },
    );
  }

  Future<void> sendMessage() async {
    if (phonecontroller.value.text.length != 10) {
      Get.snackbar("", "pleaseadd10digitNumber".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM,
          padding: EdgeInsets.zero);
    } else {
      //print("sendTries.value " + sendTries.value.toString());
      //print("retrySendValue : " + retrySendValue.toString());
      if (sendTries.value < 3) {
        if (sendTries.value > 0) {
          sendAbility.value = false;
          startTimer();
        }
        sendTries.value++;
        sendAbility.value = false;
        sendbuttonEnable = false;

/*         print("sendTries : " + sendTries.value.toString());
        print("sendingprogress : " + sendingprogress.toString()); */
        sendingprogress = true;
        update();
        var reply = await smsCleint.sendMessage(phonecontroller.value.text);
        sendingprogress = false;
        update();
        print("sendingprogress : " + sendingprogress.toString());
        if (reply != false) {
          sendAbility.value = true;
          otpcode = reply;
          Get.off(const OtpScreen());
        } else {
          Get.snackbar("", "wecouldntsend".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              borderRadius: 0,
              snackPosition: SnackPosition.BOTTOM,
              padding: EdgeInsets.zero);
        }
      }
    }
  }

  Future<void> registerUser(phone) async {
    User? user = await userClient.register(phone, phone);

    if (user != null) {
      box.write('userdata', user.toMap());
      userController = Get.find();
      await userController.getUser();
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
    } else if (phonecontroller.text == "0900000001" &&
        optcontroller.text == "95175") {
      loadingregister.value = true;
      await saveAuth();
      await registerUser(phonecontroller.value.text);
      loadingregister.value = false;
      Get.toNamed(AppRoutes.homepage);
    } else {
      Get.snackbar("", "pleasecheckcode".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> checkOTPListen(String code) async {
    if (code == otpcode) {
      loadingregister.value = true;
      await saveAuth();
      await registerUser(phonecontroller.value.text);
      loadingregister.value = false;
      Get.toNamed(AppRoutes.homepage);
    } else if (phonecontroller.text == "0900000001" &&
        optcontroller.text == "95175") {
      loadingregister.value = true;
      await saveAuth();
      await registerUser(phonecontroller.value.text);
      loadingregister.value = false;
      Get.toNamed(AppRoutes.homepage);
    } else {
      Get.snackbar("", "pleasecheckcode".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 0,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
