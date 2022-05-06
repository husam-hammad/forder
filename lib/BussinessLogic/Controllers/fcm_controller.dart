// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCMController extends GetxController {
  late final FirebaseMessaging messaging;
  @override
  void onInit() async {
    super.onInit();
    registerNotification();
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNoti(message.notification?.title, message.notification?.body);
      // Parse the message received
    });

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void showNoti(title, message) {
    Get.rawSnackbar(
      duration: const Duration(seconds: 1),
      title: title,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyles.whiteRegularHeading,
      ),
      backgroundColor: AppColors.green,
    );
  }
}
