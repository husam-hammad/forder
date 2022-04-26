// ignore_for_file: avoid_print, must_be_immutable

import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBotttomNav extends StatefulWidget {
  const CustomBotttomNav({Key? key}) : super(key: key);
  static int selectedindex = 0;
  @override
  State<CustomBotttomNav> createState() => _CustomBotttomNavState();
}

class _CustomBotttomNavState extends State<CustomBotttomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            Get.toNamed(AppRoutes.homepage);
            break;
          case 1:
            Get.toNamed(AppRoutes.notifications);
            break;
          case 2:
            Get.toNamed(AppRoutes.usercarts);
            break;
          case 3:
            Get.toNamed(AppRoutes.favorites);
            break;
        }
        MyApp.currentpage = value;
      },
      currentIndex: MyApp.currentpage,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.green,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      selectedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      unselectedIconTheme: const IconThemeData(color: Colors.white60),
      selectedLabelStyle: AppTextStyles.whiteRegularDetail,
      unselectedLabelStyle: AppTextStyles.whiteRegularDetail,
      items: const [
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home),
            label: "الرئيسية"),
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_active_outlined),
            label: "الإشعارات"),
        /* BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: ""), */
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "سلة الشراء",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
      ],
    );
  }
}
