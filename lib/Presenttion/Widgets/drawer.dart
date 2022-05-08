// ignore_for_file: avoid_print

import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/Presenttion/Screens/Auth/privacy.dart';
/* import 'package:flashorder/Presenttion/Screens/map_screen.dart'; */
/* import 'package:flashorder/Presenttion/Screens/map_screen.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
/* import 'package:get/get.dart'; */
/* import 'package:get/get.dart'; */

class PublicDrawer extends StatefulWidget {
  const PublicDrawer({Key? key}) : super(key: key);

  @override
  State<PublicDrawer> createState() => _PublicDrawerState();
}

class _PublicDrawerState extends State<PublicDrawer> {
  var box = GetStorage();
  @override
  Widget build(BuildContext context) {
    User? user;

    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
      print(box.read('userdata'));
    }
    return Drawer(
      backgroundColor: AppColors.lightwhite,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
                color: AppColors.pink,
                gradient:
                    LinearGradient(colors: [AppColors.pink, AppColors.pink2])),
            accountName: Text(
              user != null ? user.name : "مستخدم التطبيق",
              style: AppTextStyles.whiteboldHeading,
            ),
            accountEmail: Text(user != null ? user.phone : ""),
          ),
          ListTile(
            onTap: () {
              user != null
                  ? Get.toNamed(AppRoutes.profile)
                  : Get.toNamed(AppRoutes.login);
            },
            title: Text(
              user != null ? "الملف الشخصي" : "تسجيل الدخول",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(
              user != null ? Icons.person : Icons.login,
              color: AppColors.pink,
            ),
          ),
          ListTile(
            onTap: (() {
              Get.toNamed(AppRoutes.restaurents);
            }),
            title: const Text(
              "لائحة المطاعم",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(
              Icons.restaurant,
              color: AppColors.pink,
            ),
          ),
          ListTile(
            onTap: (() {
              Get.toNamed(AppRoutes.meals);
            }),
            title: const Text(
              "الوجبات",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(
              Icons.fastfood,
              color: AppColors.pink,
            ),
          ),
          /* const ListTile(
            title: Text(
              "العروض",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(
              Icons.star,
              color: AppColors.pink,
            ),
          ), */
          ListTile(
            onTap: () {
              Get.toNamed(AppRoutes.favorites);
            },
            title: const Text(
              "قائمة المفضلة",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(Icons.favorite, color: AppColors.pink),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(AppRoutes.usercarts);
            },
            title: const Text(
              "سلة الشراء",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(Icons.shopping_cart, color: AppColors.pink),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(AppRoutes.orders);
            },
            title: const Text(
              "الطلبات",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(Icons.shopping_bag, color: AppColors.pink),
          ),
          ListTile(
            onTap: () {
              Get.to(const PrivacyPolicy());
            },
            title: const Text(
              "سياسة الخصوصية",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(Icons.privacy_tip, color: AppColors.pink),
          ),
          ListTile(
            onTap: (() => Get.toNamed(AppRoutes.compliments)),
            title: const Text(
              "الشكاوى والإقتراحات",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: const Icon(Icons.radar, color: AppColors.pink),
          ),
          /*
          ListTile(
            title: Text("تسجيل الدخول"),
          ),
          ListTile(
            title: Text("تسجيل الدخول"),
          ), */
        ],
      ),
    );
  }
}
