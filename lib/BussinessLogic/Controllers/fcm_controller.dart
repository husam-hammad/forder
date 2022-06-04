// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashorder/BussinessLogic/Controllers/bottomnav_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/notification_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/local_notification_service.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCMController extends GetxController {
  late final FirebaseMessaging messaging;
  late NotificationService notificationService;
  late NotificationContoller notificationContoller =
      Get.put(NotificationContoller());
  NavController navController = Get.find();
  late String? fcmtoken;
  @override
  void onInit() async {
    super.onInit();
    registerNotification();
    notificationService = NotificationService();
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
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
    fcmtoken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await navController.animateNotification();
      //await notificationContoller.getAll();
      await notificationService.showNotifications(message.data['title'],
          message.data['body'], message.data['click_action']);
    });

    Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
      var notificationService = NotificationService();
      await notificationService.showNotifications(message.data['title'],
          message.data['body'], message.data['click_action']);
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
