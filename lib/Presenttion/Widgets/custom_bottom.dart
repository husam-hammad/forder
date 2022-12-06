// ignore_for_file: avoid_print, must_be_immutable

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10, color: color);
  }
}

class CustomBotttomNav extends StatelessWidget {
  const CustomBotttomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyleProvider(
      style: Style(),
      child: ConvexAppBar(
        height: 60,
        onTap: (value) {
          switch (value) {
            case 0:
              Get.toNamed(AppRoutes.usercarts);

              break;
            case 1:
              Get.toNamed(AppRoutes.notifications);
              break;
            case 2:
              Get.toNamed(AppRoutes.worldcup);
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
        activeColor: Colors.white,
        color: Colors.white60,
        initialActiveIndex: MyApp.currentpage,
        elevation: 20.0,
        style: TabStyle.custom,
        backgroundColor: AppColors.green,
        items: [
          TabItem(
              activeIcon:
                  const Icon(Icons.shopping_cart, color: AppColors.pink),
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white60,
              ),
              title: "mycart".tr),
          TabItem(
              activeIcon:
                  const Icon(Icons.notifications_active, color: AppColors.pink),
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.white60),
              title: "notifications".tr),
          TabItem(
              icon: const Icon(Icons.home_filled, color: Colors.white60),
              activeIcon: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    AssetImage("assets/images/worldcupanimatio.gif"),
              ),
              title: "home".tr),
          TabItem(
              activeIcon:
                  const Icon(Icons.delivery_dining, color: AppColors.pink),
              icon: const Icon(Icons.delivery_dining_rounded,
                  color: Colors.white60),
              title: "orders".tr),
          TabItem(
              activeIcon: const Icon(Icons.favorite, color: AppColors.pink),
              icon: const Icon(Icons.favorite_outline, color: Colors.white60),
              title: "favorites".tr),
        ],
        /* selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
        ), */
        /* unselectedIconTheme: const IconThemeData(color: Colors.white60),
        selectedLabelStyle: AppTextStyles.whiteRegularDetail,
        unselectedLabelStyle: AppTextStyles.whiteRegularDetail, */
        /* items: [
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
        ], */
      ),
    );
  }
}
