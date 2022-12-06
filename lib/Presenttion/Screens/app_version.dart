import 'package:flashorder/BussinessLogic/Controllers/appversion_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

import '../Widgets/appbar.dart';
import '../Widgets/custom_bottom.dart';

class AppVersion extends StatelessWidget {
  AppVersion({Key? key}) : super(key: key);
  final AppversionController controller = Get.put(AppversionController());
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
              body: Center(
                  child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "appversion".tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontSizeFactor: 1.3),
                    ),
                    Text(
                      MyApp.appVersion,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(fontSizeFactor: 1.2),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (controller.updateInfo != null &&
                        controller.updateInfo!.updateAvailability ==
                            UpdateAvailability.updateAvailable)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: CustomStyles.acceptButtonStyle,
                              onPressed: () async {
                                await controller.immediateUpdate();
                              },
                              child: Text("updateto".tr)),
                        ),
                      )
                  ],
                ),
              )),
            )));
  }
}
