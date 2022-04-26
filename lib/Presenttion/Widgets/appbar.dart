// ignore_for_file: prefer_const_constructors

import 'package:flashorder/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../../Constants/colors.dart';

PreferredSizeWidget buildAppBar() {
  return NewGradientAppBar(
    gradient: const LinearGradient(colors: [AppColors.pink, AppColors.pink2]),
    shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
    elevation: 0,
    centerTitle: true,
    title: Column(
      children: const [
        //Icon(Icons.flash_on),
        SizedBox(
          height: 5,
        ),
        Text(
          "The Flash Order",
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.toNamed(AppRoutes.usercarts);
        },
        icon: Icon(Icons.shopping_cart),
        color: Colors.white,
      ),
      IconButton(
        onPressed: () {
          /* Get.to(OtpScreen()); */
        },
        icon: Icon(Icons.search),
        color: Colors.white,
      )
    ],
  );
}
