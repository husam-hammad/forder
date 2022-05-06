import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "الأحكام والشروط",
                    style: AppTextStyles.pinkboldHeading,
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height - 200,
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: Text(content)),
            )
          ],
        ),
      ),
    ));
  }
}
