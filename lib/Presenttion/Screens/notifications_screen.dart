import 'package:flashorder/BussinessLogic/Controllers/notification_controller.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final NotificationContoller notificationContoller =
      Get.put(NotificationContoller());

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
                children: const [
                  Text(
                    "الإشعارات ",
                    style: AppTextStyles.pinkboldHeading,
                  ),
                  /* InkWell(
                    onTap: () async {
                      /* await cartController.deleteAll(); */
                    },
                    child: const Text(
                      "عرض الكل",
                      style: AppTextStyles.greyregular,
                    ),
                  ) */
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              height: Get.height - 200,
              child: GetBuilder(
                init: notificationContoller,
                builder: (_) {
                  if (notificationContoller.notifications.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await notificationContoller.getAll();
                      },
                      child: ListView.builder(
                        itemCount: notificationContoller.notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          // ignore: avoid_print
                          return InkWell(
                            onTap: () {
                              notificationContoller.gotopage(
                                  notificationContoller
                                      .notifications[index].modelName);
                            },
                            child: NotificationItem(
                                notification:
                                    notificationContoller.notifications[index]),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
