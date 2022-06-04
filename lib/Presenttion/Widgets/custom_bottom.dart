// ignore_for_file: avoid_print, must_be_immutable

import 'package:flashorder/BussinessLogic/Controllers/bottomnav_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomBotttomNav extends StatelessWidget {
  CustomBotttomNav({Key? key}) : super(key: key);
  final NavController navController = Get.find();
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
            Get.toNamed(AppRoutes.orders);
            break;
          case 4:
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
      items: [
        const BottomNavigationBarItem(
            activeIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home),
            label: "الرئيسية"),
        BottomNavigationBarItem(
            icon: GetBuilder(
                init: navController,
                builder: (_) {
                  return Lottie.asset('assets/images/noti.json',
                      width: 30,
                      height: 30,
                      controller: navController.animationController,
                      onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    navController.animationController
                      ..duration = composition.duration
                      //;const Duration(microseconds: 200)
                      ..forward();
                  });
                }),
            /*          icon: const Icon(Icons.notifications_outlined), */
            label: "الإشعارات"),
        /* BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: ""), */
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "سلة الشراء",
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(Icons.delivery_dining),
          icon: Icon(Icons.delivery_dining_rounded),
          label: "الطلبات",
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: "المفضلة"),
      ],
    );
  }
}
