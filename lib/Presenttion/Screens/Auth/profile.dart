import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
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
                children: const [
                  Text(
                    "الملف الشخصي ",
                    style: AppTextStyles.pinkboldTopPage,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: Get.height - 215,
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
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("عدد النقاط لديك :",
                          style: AppTextStyles.greenboldHeading),
                      Obx(() {
                        return Text(userController.points.toString(),
                            style: AppTextStyles.greyregular);
                      })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: userController.namecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        labelText: 'الاسم',
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
                        labelText: 'رقم الهاتف',
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
                        labelText: 'العنوان',
                        hintText: 'لمساعدة الكابتن في الوصول إليك بدقة',
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
                        labelText: 'تاريخ الميلاد',
                        labelStyle: AppTextStyles.greenRegularTitle,
                        enabledBorder: CustomStyles.pinkBorder,
                        focusedBorder: CustomStyles.greenBorder),
                  )
                ],
              ),
            )
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
                ? const Text(
                    "جاري الحفظ ..",
                    style: AppTextStyles.whiteRegularDetail,
                  )
                : const Text(
                    " حفظ",
                    style: AppTextStyles.whiteRegularDetail,
                  );
          })),
    );
  }
}
