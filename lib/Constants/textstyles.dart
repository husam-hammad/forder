import 'package:flashorder/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyles {
  static var family = Get.locale?.languageCode == "en" ? "Montserrat" : "Cairo";

  static const greyboldHeading = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const greyBoldDetail = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12.0);
  static const greyBoldDetailDark = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.lightgrey,
      fontWeight: FontWeight.bold,
      fontSize: 10.0);
  static const greyRegularDetail = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.grey,
      fontWeight: FontWeight.normal,
      fontSize: 10.0);
  static const greyregular = TextStyle(
      fontSize: 8,
      fontFamily: "Cairo",
      color: AppColors.grey,
      fontWeight: FontWeight.normal);
  static const greyregularDark = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.grey,
      fontWeight: FontWeight.normal);
  static const greenboldHeading = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.green,
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const greenboldHeadingDark = TextStyle(
      fontFamily: "Cairo",
      color: Color.fromARGB(255, 0, 218, 207),
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const greenRegularHeading = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.green,
      fontWeight: FontWeight.bold,
      fontSize: 12.0);
  static const redRegularHeading = TextStyle(
      fontFamily: "Cairo",
      color: Colors.redAccent,
      fontWeight: FontWeight.bold,
      fontSize: 12.0);
  static const greenRegularHeadingDark = TextStyle(
      fontFamily: "Cairo",
      color: Color.fromARGB(255, 0, 218, 207),
      fontWeight: FontWeight.bold,
      fontSize: 12.0);
  static const pinkboldTopPage = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 19.0);
  static const pinkboldTopPageDark = TextStyle(
      fontFamily: "Cairo",
      color: Color.fromARGB(255, 180, 81, 179),
      fontWeight: FontWeight.bold,
      fontSize: 19.0);
  static const pinkboldHeading = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const pinkRegularHeading = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const greenRegularTitle = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.green,
      fontWeight: FontWeight.normal,
      fontSize: 12.0);
  static const greenBoldTitle = TextStyle(
      fontFamily: "Cairo",
      color: AppColors.green,
      fontWeight: FontWeight.bold,
      fontSize: 12.0);
  static const greenBoldTitleDark = TextStyle(
      fontFamily: "Cairo",
      color: Color.fromARGB(255, 0, 218, 207),
      fontWeight: FontWeight.bold,
      fontSize: 12.0);
  static const greenRegularTitleDark = TextStyle(
      fontFamily: "Cairo",
      color: Color.fromARGB(255, 0, 218, 207),
      fontWeight: FontWeight.normal,
      fontSize: 12.0);

  static const whiteboldHeading = TextStyle(
      fontFamily: "Cairo",
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const whiteboldHeadingDark = TextStyle(
      fontFamily: "Cairo",
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15.0);
  static const whiteRegularHeading = TextStyle(
      fontFamily: "Cairo",
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 15.0);
  static const whiteRegularDetail = TextStyle(
      fontFamily: "Cairo",
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 10);
}
