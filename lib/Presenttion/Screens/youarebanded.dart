import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/colors.dart';

class YouAreBanded extends StatelessWidget {
  const YouAreBanded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.orange,
                      size: 100,
                    ),
                    Text(
                      "YouAreBanded".tr,
                      style: AppTextStyles.pinkRegularHeading,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: "0939998886",
                          );
                          launchUrl(launchUri);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        child: Text(
                          "contactsupport".tr,
                          style: AppTextStyles.whiteboldHeading,
                        ))
                  ],
                ),
              ),
            )));
  }
}
