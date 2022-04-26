import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "الإشعارات ",
                    style: AppTextStyles.pinkboldHeading,
                  ),
                  InkWell(
                    onTap: () async {
                      /* await cartController.deleteAll(); */
                    },
                    child: const Text(
                      "عرض الكل",
                      style: AppTextStyles.greyregular,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
