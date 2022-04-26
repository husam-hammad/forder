import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
/* import 'package:flashorder/Presenttion/Screens/map_screen.dart'; */
/* import 'package:flashorder/Presenttion/Screens/map_screen.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/* import 'package:get/get.dart'; */
/* import 'package:get/get.dart'; */

class PublicDrawer extends StatefulWidget {
  const PublicDrawer({Key? key}) : super(key: key);

  @override
  State<PublicDrawer> createState() => _PublicDrawerState();
}

class _PublicDrawerState extends State<PublicDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.lightwhite,
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: AppColors.pink,
                gradient:
                    LinearGradient(colors: [AppColors.pink, AppColors.pink2])),
            accountName: Text(
              "مستخدم التطبيق",
              style: AppTextStyles.whiteboldHeading,
            ),
            accountEmail: Text("0900000000"),
          ),
          const ListTile(
            title: Text(
              "تسجيل الدخول",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(
              Icons.login,
              color: AppColors.pink,
            ),
          ),
          const ListTile(
            title: Text(
              "لائحة المطاعم",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(
              Icons.restaurant,
              color: AppColors.pink,
            ),
          ),
          const ListTile(
            title: Text(
              "الوجبات",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(
              Icons.fastfood,
              color: AppColors.pink,
            ),
          ),
          const ListTile(
            title: Text(
              "العروض",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(
              Icons.star,
              color: AppColors.pink,
            ),
          ),
          const ListTile(
            title: Text(
              "قائمة المفضلة",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(Icons.favorite, color: AppColors.pink),
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
          const ListTile(
            title: Text(
              "الطلبات",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(Icons.shopping_bag, color: AppColors.pink),
          ),
          const ListTile(
            title: Text(
              "سياسة الخصوصية",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(Icons.privacy_tip, color: AppColors.pink),
          ),
          const ListTile(
            title: Text(
              "الشكاوى والإقتراحات",
              style: AppTextStyles.greenRegularHeading,
            ),
            leading: Icon(Icons.radar, color: AppColors.pink),
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
