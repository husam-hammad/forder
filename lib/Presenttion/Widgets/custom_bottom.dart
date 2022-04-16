import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBotttomNav extends StatelessWidget {
  const CustomBotttomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        if (value == 3) {
          Get.toNamed("/favorites");
        }
      },
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
            icon: Icon(Icons.home_filled), label: "الرئيسية"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active), label: "الإشعارات"),
        /* BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: ""), */
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: "سلة الشراء"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "المفضلة"),
      ],
    );
  }
}
