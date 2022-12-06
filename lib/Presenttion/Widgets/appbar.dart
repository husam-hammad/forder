// ignore_for_file: prefer_const_constructors, avoid_print

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
      children: [
        //Icon(Icons.flash_on),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/images/logo-white.png",
          width: 100,
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
          Get.toNamed(AppRoutes.search);
        },
        icon: Icon(Icons.search),
        color: Colors.white,
      )
    ],
  );
}
