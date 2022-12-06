import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/loading_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    userController.getPoints();
    return SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(),
        bottomNavigationBar: buildNavButton(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "profile".tr,
                    style: AppTextStyles.pinkboldTopPage,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: Get.height - 300,
                width: double.infinity,
                child: ListView(
                  children: [
                    Center(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            userController
                                .imageOptions(userController.user!.avatar);
                          },
                          child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.green,
                              backgroundImage:
                                  userController.user!.avatar != '' &&
                                          userController.user!.avatar !=
                                              'users/default.png'
                                      ? CachedNetworkImageProvider(
                                          userController.buildUserAvatar(
                                              userController.user!.avatar))
                                      : null),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("numberofpoints".tr,
                            style: AppTextStyles.greenboldHeading),
                        Obx(() {
                          return Text(userController.points.toString(),
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTextStyles.whiteRegularDetail
                                      .apply(fontSizeFactor: 2)
                                  : AppTextStyles.greyregular
                                      .apply(fontSizeFactor: 2));
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //إهداء النقاط
                    /* Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: CustomStyles.secondaryButtonStyle,
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/coins.png',
                                width: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "إهداء النقاط",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                        color: Colors.white,
                                        fontWeightDelta: -1),
                              )
                            ],
                          )),
                    ), */
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: userController.namecontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          labelText: 'name'.tr,
                          labelStyle: AppTextStyles.greenRegularTitle,
                          enabledBorder: CustomStyles.pinkBorder,
                          focusedBorder: CustomStyles.greenBorder),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: userController.phonecontroller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          labelText: 'phone'.tr,
                          labelStyle: AppTextStyles.greenRegularTitle,
                          enabledBorder: CustomStyles.pinkBorder,
                          focusedBorder: CustomStyles.greenBorder),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: userController.adresscontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          labelText: 'adress'.tr,
                          hintText: 'adressforcaptin'.tr,
                          labelStyle: AppTextStyles.greenRegularTitle,
                          enabledBorder: CustomStyles.pinkBorder,
                          focusedBorder: CustomStyles.greenBorder),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onTap: () {
                        userController.selectDate(context);
                      },
                      controller: userController.birthdaycontroller,
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          labelText: 'birthday'.tr,
                          labelStyle: AppTextStyles.greenRegularTitle,
                          enabledBorder: CustomStyles.pinkBorder,
                          focusedBorder: CustomStyles.greenBorder),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildNavButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            userController.saveData();
          },
          style: CustomStyles.acceptButtonStyle,
          child: Obx(() {
            return userController.saving.value == true
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loadingItem(),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "saving".tr,
                        style: AppTextStyles.whiteRegularDetail,
                      )
                    ],
                  )
                : Text(
                    "save".tr,
                    style: AppTextStyles.whiteRegularDetail,
                  );
          })),
    );
  }
}
