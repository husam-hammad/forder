import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/onboarding.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key, required this.forAccept}) : super(key: key);
  final bool forAccept;
  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String content = "";

  void loadPrivacy() async {
    String text = await rootBundle.loadString('assets/privacy_policy.txt');
    setState(() {
      content = text;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPrivacy();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightwhite,
        appBar: NewGradientAppBar(
          gradient:
              const LinearGradient(colors: [AppColors.pink, AppColors.pink2]),
          shape: const ContinuousRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100))),
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              //Icon(Icons.flash_on),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/logo-white.png",
                width: 100,
              )
            ],
          ),
        ),
        bottomNavigationBar: widget.forAccept == true
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: CustomStyles.acceptButtonStyle,
                  onPressed: () {
                    Get.to(const OnBoardingPage());
                  },
                  child: Text(
                    "acceptterms".tr,
                    style: AppTextStyles.whiteRegularHeading,
                  ),
                ),
              )
            : Row(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "privacypolicy".tr,
                    style: AppTextStyles.pinkboldTopPage,
                  ),
                ],
              ),
            ),
            Container(
              height: widget.forAccept == true
                  ? Get.height - 250
                  : Get.height - 210,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: Text(content)),
            )
          ],
        ),
      ),
    ));
  }
}
