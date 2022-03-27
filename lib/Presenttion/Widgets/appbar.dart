// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    toolbarHeight: 70,
    shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
    backgroundColor: AppColors.pink,
    elevation: 0,
    centerTitle: true,
    title: Column(
      children: const [
        Icon(Icons.flash_on),
        Text(
          "The Flash Order",
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          /* Get.to(Login()); */
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
