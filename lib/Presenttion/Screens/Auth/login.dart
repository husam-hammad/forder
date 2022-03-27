import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/Auth/otp.dart';
import 'package:flashorder/Presenttion/Widgets/bottom_cropper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "سجل دخولك لتستفيد من خدمات التطبيق بشكل كامل , لتصلك آخر العروض و تحصل على رصيد للنقاط",
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
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        "The Flash Order",
                        style: AppTextStyles.whiteboldHeading,
                      ),
                      Text(
                        "تسجيل الدخول",
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
                      const Text(
                        "قم بإدخال رقم هاتفك",
                        style: AppTextStyles.greyregular,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
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
                                Get.to(const OtpScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: AppColors.green,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                              child: const Text(
                                "إرسال الرمز",
                                style: AppTextStyles.whiteboldHeading,
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: Get.width,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: AppColors.lightgrey,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                              child: const Text(
                                "تخطي",
                                style: AppTextStyles.whiteboldHeading,
                              ))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
