// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

import 'package:flashorder/BussinessLogic/Controllers/auth_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController authController = Get.find();
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Get.locale!.languageCode == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: GetBuilder(
                init: authController,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    width: Get.width,
                    height: Get.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height / 8,
                        ),
                        Center(
                            child: LottieBuilder.asset(
                          'assets/images/message.json',
                          width: Get.width - 50,
                        )),
                        /* Image.asset('assets/images/sms.png'), */
                        Text(
                          'wehavesend'.tr,
                          style: AppTextStyles.greyboldHeading,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "enter5code".tr,
                                style: AppTextStyles.greyregular
                                    .apply(fontSizeFactor: 1.5),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        Form(key: formKey, child: buildpincode()),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.message,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Obx(() {
                                return InkWell(
                                  child: Text(
                                      authController.sendAbility.value == true
                                          ? "resendcode".tr
                                          : (authController.sendTries.value > 1
                                                  ? "resendcodeafter".tr +
                                                      authController
                                                          .retrySendValue.value
                                                          .toString()
                                                  : "resendcode".tr)
                                              .toString(),
                                      style: AppTextStyles.greenRegularHeading),
                                  onTap: () async {
                                    print(authController.sendAbility.value);
                                    if (authController.sendAbility.value ==
                                        true) {
                                      await authController.sendMessage();
                                    }
                                  },
                                );
                              })
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              authController.checkOTP();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              textStyle: AppTextStyles.whiteRegularHeading,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              minimumSize: Size(Get.width, 50),
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Text(
                              "verifycode".tr,
                              style: AppTextStyles.whiteboldHeading,
                            )),
                        Obx(() {
                          if (authController.loadingregister.value == true) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: AppColors.pink,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "loginprogress".tr,
                                  style: AppTextStyles.greenRegularTitle,
                                )
                              ],
                            );
                          } else {
                            return Row();
                          }
                        }),
                      ],
                    ),
                  );
                }),
          ),
        ));
  }

  Widget buildpincode() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        length: 5,
        appContext: context,
        autoFocus: true,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {},
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            inactiveFillColor: AppColors.lightwhite,
            inactiveColor: AppColors.lightgrey,
            selectedFillColor: AppColors.green,
            activeColor: AppColors.green),
        cursorColor: Colors.white,
        textStyle: TextStyle(color: AppColors.pink),
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: authController.optcontroller,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        onCompleted: (v) {
          authController.checkOTP();
        },
      ),
    );
  }
}
