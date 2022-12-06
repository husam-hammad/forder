import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            'assets/images/noconnection.json',
            width: Get.width - 200,
          ),
          Text(
            "noconnection".tr,
            style: AppTextStyles.pinkboldHeading,
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
