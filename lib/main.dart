// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashorder/BussinessLogic/Bindings/init_binding.dart';
import 'package:flashorder/BussinessLogic/Providers/local_notification_service.dart';
import 'package:flashorder/BussinessLogic/router.dart';
import 'package:flashorder/Presenttion/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/* import 'package:telephony/telephony.dart'; */

import 'Constants/Lang/languages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await NotificationService().init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp(
      /*  initroute: initroute, */
      ));
}

/* backgrounMessageHandler(SmsMessage message) async {
  //Handle background message
  // You can also call other plugin in here
} */
@pragma('vm:entry-point')
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data['type']);
  await Firebase.initializeApp();
  var notificationService = NotificationService();
  print(message.data['type']);
  if (message.data['type'] == null) {
    await notificationService.showNotifications(message.data['title'],
        message.data['body'], message.data['click_action']);
  } else if (message.data['type'] == "check") {
    print("Show Check Noti");
    await notificationService.showNotifications(message.data['title'],
        message.data['body'], message.data['click_action']);
  } else if (message.data['type'] == "ads") {
    await notificationService.showNotifications(message.data['title'],
        message.data['body'], message.data['click_action']);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  /*  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 500;
  } */

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    /*  required this.initroute */
  }) : super(key: key);

  static String appVersion = "1.0.8";
  static int currentpage = 2;
  static late Position? userPosition;
  static late num perKmCost = 0;
  static late num minDeliveryCost = 1500;
  static late String newAppVersion = "";
  static late num allowEditState = 4;
  static late num pointcost = 0;
  static String settingAppVersion = "0";
  static bool settingMandatoryUpdate = false;
  final box = GetStorage();
  // This widget is the root of your application.
/*   final String initroute; */
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      debugShowCheckedModeBanner: false,
      title: 'FlashOrder',
      translations: Languages(),
      locale: box.read('lang') != null
          ? Locale.fromSubtags(languageCode: box.read('lang'))
          : Get.deviceLocale,
      fallbackLocale: const Locale('ar', 'AR'),
      theme: box.read('theme') != null
          ? (box.read('theme') == "light"
              ? Themes.lightTheme
              : Themes.darkTheme)
          : Themes.lightTheme,
      getPages: routes,
      /* initialRoute: initroute, */
    );
  }
}
