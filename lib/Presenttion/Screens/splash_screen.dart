// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flashorder/BussinessLogic/Controllers/splash_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcfcff),
      body: Center(
        child: Image.asset(
          //"assets/images/logo-animation.gif",
          "assets/images/worldcupanimatio.gif",

          width: Get.width * .6,
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.pink,
        height: 5,
        width: Get.width,
      ),
    );
  }
}
