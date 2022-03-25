import 'dart:io';

import 'package:flashorder/BussinessLogic/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 500;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlashOrder',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Cairo"),
      getPages: routes,
    );
  }
}
