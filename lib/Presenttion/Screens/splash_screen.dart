// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Presenttion/Screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double rwidth = 0;
  void navigatetohome() async {
    return Future.delayed(Duration(seconds: 3))
        .then((value) => Get.to(() => OnBoardingPage()));
  }

  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: Get.width / 2,
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
