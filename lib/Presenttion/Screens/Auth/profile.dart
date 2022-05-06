import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final UserController userController = Get.put(UserController());
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
                    style: AppTextStyles.pinkboldHeading,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: Get.height - 300,
              width: double.infinity,
              child: ListView(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "عدد النقاط لديك : ",
                        style: AppTextStyles.greenboldHeading),
                    TextSpan(
                        text: userController.points,
                        style: AppTextStyles.greyregular),
                  ])),
                  const SizedBox(
                    height: 50,
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
                    controller: userController.birthdaycontroller,
                    keyboardType: TextInputType.datetime,
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
          child: const Text(
            "حفظ",
            style: AppTextStyles.whiteRegularDetail,
          )),
    );
  }
}
