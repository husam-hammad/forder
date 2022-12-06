import 'package:flashorder/Constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Constants/colors.dart';

class MandatoryUpdate extends StatelessWidget {
  const MandatoryUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "pleaseupdate".tr,
                      style: AppTextStyles.pinkRegularHeading,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          /*   final Uri launchUri =
                              Uri(host: "https://theflashorder.sy/"); */
                          launchUrlString("https://theflashorder.sy/",
                              webViewConfiguration: const WebViewConfiguration(
                                  enableJavaScript: true));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        child: Text(
                          "updatelink".tr,
                          style: AppTextStyles.whiteboldHeading,
                        ))
                  ],
                ),
              ),
            )));
  }
}
