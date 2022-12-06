// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/notification_controller.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final notificationContoller = Get.put(NotificationContoller());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    /* scrollController.addListener(() {
// nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (scrollController.position.pixels > nextPageTrigger) {
        print("is next");
        notificationContoller.getAll();
      }
    }); */
    return SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
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
                  Text(
                    "notifications".tr,
                    style: AppTextStyles.pinkboldTopPage,
                  ),
                  InkWell(
                    onTap: () async {
                      await notificationContoller.getAll(false);
                    },
                    child: Text(
                      "loadmore".tr,
                      style: AppTextStyles.greyregular,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              height: Get.height - 220,
              child: GetBuilder(
                init: notificationContoller,
                builder: (_) {
                  if (notificationContoller.notifications.isNotEmpty &&
                      notificationContoller.endloading) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await notificationContoller.getAll(true);
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: notificationContoller.notifications.length,
                        itemBuilder: (BuildContext context, int index) {
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
                  } else if (notificationContoller.notifications.isEmpty &&
                      notificationContoller.endloading) {
                    return Center(
                      child: Text("nonotifications".tr),
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
