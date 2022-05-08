import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashorder/BussinessLogic/Bindings/init_binding.dart';
import 'package:flashorder/BussinessLogic/Providers/local_notification_service.dart';
import 'package:flashorder/BussinessLogic/router.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await NotificationService().init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var notificationService = NotificationService();
  await notificationService.showNotifications(message.data['title'],
      message.data['body'], message.data['click_action']);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 500;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static int currentpage = 0;
  static late Position? userPosition;
  static late num perKmCost = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      debugShowCheckedModeBanner: false,
      title: 'FlashOrder',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Cairo"),
      getPages: routes,
    );
  }
}
