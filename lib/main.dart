import 'package:flashorder/BussinessLogic/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
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
