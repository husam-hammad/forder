import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/onboarding.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

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
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightwhite,
        appBar: buildAppBar(),
        bottomNavigationBar: widget.forAccept == true
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: CustomStyles.acceptButtonStyle,
                  onPressed: () {
                    Get.to(const OnBoardingPage());
                  },
                  child: const Text(
                    "أوافق على الأحكام والشروط",
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
                children: const <Widget>[
                  Text(
                    "سياسة الاستخدام",
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
