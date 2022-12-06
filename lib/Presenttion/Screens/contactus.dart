import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          bottomNavigationBar: const CustomBotttomNav(),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "contactus".tr,
                        style: AppTextStyles.pinkboldTopPage,
                      ),
                    ],
                  ),
                ),
                Text(
                  "contactusdesc".tr,
                  style: AppTextStyles.greyregular,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          "0119691",
                          style: AppTextStyles.greenboldHeading,
                        ),
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                        ),
                        subtitle: Text("quadnumber".tr,
                            style: AppTextStyles.greyRegularDetail),
                        onTap: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: "0119691",
                          );
                          launchUrl(launchUri);
                          /* launch("tel://214324234"); */
                        },
                      ),
                      ListTile(
                        title: const Text(
                          "0939998886",
                          style: AppTextStyles.greenboldHeading,
                        ),
                        leading: const Icon(
                          Icons.call,
                          color: Colors.blueAccent,
                        ),
                        subtitle: Text(
                          "phone".tr,
                          style: AppTextStyles.greyRegularDetail,
                        ),
                        onTap: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: "0939998886",
                          );
                          launchUrl(launchUri);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'companyname'.tr,
                        style: AppTextStyles.pinkboldHeading,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.room),
                          Text(
                            "companyadress".tr,
                            style: AppTextStyles.greyregular,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
