// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flashorder/BussinessLogic/Controllers/auth_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
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
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 8,
                  ),
                  Image.asset('assets/images/sms.png'),
                  Text(
                    "قمنا بإرسال رمز إلى هاتفك لنتمكن من تأكيد حسابك ,قم بإدخاله في الخانات في الأسفل حال وصوله",
                    style: AppTextStyles.greyboldHeading,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "قم بإدخال الرمز المكون من 5  أرقام",
                          style: AppTextStyles.greyregular,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Form(key: formKey, child: buildpincode()),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.message,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "إعادة إرسال الرمز",
                          style: AppTextStyles.greyregular,
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        minimumSize: Size(Get.width, 50),
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        "تأكيد الرمز",
                        style: AppTextStyles.whiteboldHeading,
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildpincode() {
    return PinCodeTextField(
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
      controller: textEditingController,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: (v) {
        authController.checkOTP(v);
      },
    );
  }
}
