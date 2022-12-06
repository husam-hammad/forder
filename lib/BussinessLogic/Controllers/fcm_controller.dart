// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashorder/BussinessLogic/Controllers/map_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/notification_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/orderscreen_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/local_notification_service.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/location_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'orders_controller.dart';

class FCMController extends GetxController {
  late final FirebaseMessaging messaging;
  late NotificationService notificationService;
  late NotificationContoller notificationContoller =
      Get.put(NotificationContoller());
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
      //await notificationContoller.getAll();
      print("message");
      if (message.data['type'] != null) {
        if (message.data['type'] == 'captin_location') {
          print(message.data['data']);
          LocationItem locationItem =
              LocationItem.fromMap(jsonDecode(message.data['data']));
          if (Get.isRegistered<MapScreenController>()) {
            MapScreenController mapController = Get.find();
            mapController.updateCaptinLocation(
                locationItem.lat /* + (Random().nextDouble() / 1000) */,
                locationItem.long /* + (Random().nextDouble() / 1000) */);
          }
        } else if (message.data['type'] == "check") {
          Get.toNamed(message.data['click_action']);
          await notificationService.showNotifications(message.data['title'],
              message.data['body'], message.data['click_action']);
        } else if (message.data['type'] == "ads") {
          Get.defaultDialog(
              title: message.data['title']!,
              middleText: message.data['body'],
              titleStyle: AppTextStyles.greenRegularHeading,
              middleTextStyle: AppTextStyles.pinkboldHeading);
          // Get.toNamed(message.data['click_action']);
          await notificationService.showNotifications(message.data['title'],
              message.data['body'], message.data['click_action']);
        }
      } else {
        if (message.data['click_action'].toString().contains("ratingscreen")) {
          Get.toNamed(message.data['click_action']);
        } else if (message.data['click_action']
            .toString()
            .contains("/homepage/order")) {
          final checkordercontrollerexist = Get.isRegistered<OrderController>();
          final checkorderscreencontrollerexist =
              Get.isRegistered<OrderScreenController>();
          if (!checkordercontrollerexist) {
            Get.put(OrderController());
          } else {
            OrderController orderController = Get.find();
            orderController.getAll();
            orderController.refresh();
          }
          if (checkorderscreencontrollerexist) {
            print("exist");
            OrderScreenController orderScreenController = Get.find();
            orderScreenController.onInit();
          }
        }

        await notificationService.showNotifications(message.data['title'],
            message.data['body'], message.data['click_action']);
      }
    });

    Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      print("incomming message");
      print(message);
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
