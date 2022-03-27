import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';

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
        children: const [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.pink),
            accountName: Text(
              "مستخدم التطبيق",
              style: AppTextStyles.whiteboldHeading,
            ),
            accountEmail: Text("0900000000"),
          ),
          ListTile(
            title: Text("تسجيل الدخول"),
          )
        ],
      ),
    );
  }
}
