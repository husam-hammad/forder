import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      backgroundColor: AppColors.lightwhite,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColor: AppColors.pink,
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.pinkboldTopPage,
        displayMedium: AppTextStyles.greyBoldDetail,
        displaySmall: AppTextStyles.greyregular,
        titleLarge: AppTextStyles.whiteboldHeading,
        titleMedium: AppTextStyles.greenboldHeading,
        titleSmall: AppTextStyles.greenRegularHeading,
        bodyMedium: AppTextStyles.greenBoldTitle,
        bodySmall: AppTextStyles.greyRegularDetail,
      ).apply(fontFamily: "Cairo"));
  static ThemeData darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 43, 33, 48),
      backgroundColor: const Color.fromARGB(255, 74, 48, 87),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.pinkboldTopPageDark,
        displayMedium: AppTextStyles.greyBoldDetailDark,
        displaySmall: AppTextStyles.greyregularDark,
        titleLarge: AppTextStyles.whiteboldHeading,
        titleMedium: AppTextStyles.greenboldHeadingDark,
        titleSmall: AppTextStyles.whiteRegularHeading,
        bodyMedium: AppTextStyles.greenBoldTitleDark,
        bodySmall: AppTextStyles.whiteRegularDetail,
      ).apply(fontFamily: "Cairo"));
  static ThemeData vipTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 43, 33, 48),
      backgroundColor: const Color.fromARGB(255, 74, 48, 87),
      brightness: Brightness.dark,
      primaryColor: const Color.fromARGB(255, 224, 224, 22),
      textTheme: TextTheme(
        displayLarge:
            AppTextStyles.pinkboldTopPageDark.apply(fontFamily: "Cairo"),
        displayMedium:
            AppTextStyles.greyBoldDetailDark.apply(fontFamily: "Cairo"),
        displaySmall: AppTextStyles.greyregularDark.apply(fontFamily: "Cairo"),
        titleLarge: AppTextStyles.whiteboldHeading.apply(fontFamily: "Cairo"),
        titleMedium:
            AppTextStyles.greenboldHeadingDark.apply(fontFamily: "Cairo"),
        titleSmall:
            AppTextStyles.whiteRegularHeading.apply(fontFamily: "Cairo"),
        bodyMedium: AppTextStyles.greenBoldTitleDark.apply(fontFamily: "Cairo"),
        bodySmall: AppTextStyles.whiteRegularDetail.apply(fontFamily: "Cairo"),
      ).apply(fontFamily: "Cairo"));
}
