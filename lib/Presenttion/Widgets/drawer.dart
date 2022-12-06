// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/Auth/privacy.dart';
import 'package:flashorder/helpers/image_helper.dart';
/* import 'package:flashorder/Presenttion/Screens/map_screen.dart'; */
/* import 'package:flashorder/Presenttion/Screens/map_screen.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* import 'package:get/get.dart'; */
/* import 'package:get/get.dart'; */
/*  */
class PublicDrawer extends StatelessWidget {
  const PublicDrawer({Key? key, required this.userController})
      : super(key: key);
  final UserController userController;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: GetBuilder(
            init: userController,
            builder: (_) {
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: AppColors.green,
                      backgroundImage: userController.user != null
                          ? CachedNetworkImageProvider(ImageHelper.buildImage(
                              storageUrl + userController.user!.avatar))
                          : null,
                    ),
                    decoration: const BoxDecoration(
                        color: AppColors.pink,
                        gradient: LinearGradient(
                            colors: [AppColors.pink, AppColors.pink2])),
                    accountName: Text(
                      userController.user != null
                          ? userController.user!.name
                          : "appuser".tr,
                      style: AppTextStyles.whiteboldHeading,
                    ),
                    accountEmail: Text(userController.user != null
                        ? userController.user!.phone
                        : ""),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        InkWell(
                          child: Text(
                            "العربية",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(fontSizeFactor: 1.5),
                          ),
                          onTap: () async {
                            await userController
                                .changeLang(const Locale("ar", "AR"));
                          },
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          child: Text(
                            "EN",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(fontSizeFactor: 1.5),
                          ),
                          onTap: () async {
                            await userController
                                .changeLang(const Locale("en", "US"));
                          },
                        )
                      ]),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      userController.user != null
                          ? Get.toNamed(AppRoutes.profile)
                          : Get.toNamed(AppRoutes.login);
                    },
                    title: Text(
                      userController.user != null ? "profile".tr : "login".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: Icon(
                      userController.user != null ? Icons.person : Icons.login,
                      color: AppColors.pink,
                    ),
                  ),
                  ListTile(
                      onTap: (() {
                        Get.toNamed(AppRoutes.worldcup);
                      }),
                      title: Text(
                        "كأس العالم",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      leading: Image.asset(
                        "assets/images/cupicon.png",
                        height: 30,
                      )),
                  ListTile(
                    onTap: (() {
                      Get.toNamed(AppRoutes.places);
                    }),
                    title: Text(
                      "pinnedplaces".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: const Icon(
                      Icons.room,
                      color: AppColors.pink,
                    ),
                  ),
                  ListTile(
                    onTap: (() {
                      Get.toNamed(AppRoutes.restaurents);
                    }),
                    title: Text(
                      "restaurentslist".tr,
                      style: Theme.of(context).textTheme.titleSmall,
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
                    title: Text(
                      "mealslist".tr,
                      style: Theme.of(context).textTheme.titleSmall,
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
                    title: Text(
                      "favoriteslist".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: const Icon(Icons.favorite, color: AppColors.pink),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.usercarts);
                    },
                    title: Text(
                      "mycart".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading:
                        const Icon(Icons.shopping_cart, color: AppColors.pink),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.orders);
                    },
                    title: Text(
                      "orders".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading:
                        const Icon(Icons.shopping_bag, color: AppColors.pink),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(const PrivacyPolicy(
                        forAccept: false,
                      ));
                    },
                    title: Text(
                      "privacypolicy".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading:
                        const Icon(Icons.privacy_tip, color: AppColors.pink),
                  ),
                  Theme.of(context).brightness == Brightness.dark
                      ? ListTile(
                          leading:
                              const Icon(Icons.wb_sunny, color: AppColors.pink),
                          title: Text("lightmode".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          onTap: () async {
                            userController.changetheme();
                          },
                        )
                      : ListTile(
                          leading:
                              const Icon(Icons.wb_sunny, color: AppColors.pink),
                          title: Text("darkmode".tr,
                              style: Theme.of(context).textTheme.titleSmall),
                          onTap: () async {
                            userController.changetheme();
                          },
                        ),
                  ListTile(
                    onTap: (() => Get.toNamed(AppRoutes.compliments)),
                    title: Text(
                      "complaintsandsuggestions".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: const Icon(Icons.radar, color: AppColors.pink),
                  ),
                  ListTile(
                    onTap: (() => userController.showContactus()),
                    title: Text(
                      "contactus".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: const Icon(Icons.call, color: AppColors.pink),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRoutes.appversion);
                    },
                    title: Text(
                      "appversion".tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    leading: const Icon(Icons.settings, color: AppColors.pink),
                  ),
                  userController.user != null
                      ? ListTile(
                          onTap: () async {
                            await userController.logout();
                          },
                          title: Text(
                            "logout".tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          leading:
                              const Icon(Icons.logout, color: AppColors.pink),
                        )
                      : Row()
                  /*
          ListTile(
            title: Text("تسجيل الدخول"),
          ),
          ListTile(
            title: Text("تسجيل الدخول"),
          ), */
                ],
              );
            }));
  }
}
