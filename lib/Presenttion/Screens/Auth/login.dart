// ignore_for_file: must_be_immutable, avoid_print

import 'package:flashorder/BussinessLogic/Controllers/auth_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/bottom_cropper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/routes.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Get.locale!.languageCode == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'logintitle'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.greyregular,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                    color: AppColors.pink,
                    width: Get.width,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "The Flash Order",
                          style: AppTextStyles.whiteboldHeading,
                        ),
                        Text(
                          'login'.tr,
                          style: AppTextStyles.whiteboldHeading,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height / 8,
                        ),
                        Text(
                          "addyourphonenumber".tr,
                          style: AppTextStyles.greenRegularTitle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: authController.phonecontroller,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "09XXXXXXXX",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 172, 172, 172)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: AppColors.pink,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: AppColors.lightgrey, width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  authController.sendMessage();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.green,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                child: GetBuilder(
                                    init: authController,
                                    builder: (_) {
                                      return authController.sendingprogress !=
                                              true
                                          ? Text(
                                              "sendcode".tr,
                                              style: AppTextStyles
                                                  .whiteboldHeading,
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "sending".tr,
                                                  style: AppTextStyles
                                                      .whiteboldHeading,
                                                )
                                              ],
                                            );
                                    }))),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.homepage);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.lightgrey,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                child: Text(
                                  "skip".tr,
                                  style: AppTextStyles.whiteboldHeading,
                                ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
