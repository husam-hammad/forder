import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/back_notification.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);
  final BackNotification notification;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: CustomStyles.raduis50),
      width: double.infinity,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: Get.width / 10,
                foregroundColor: AppColors.lightgrey,
                backgroundColor: AppColors.lightgrey,
                backgroundImage: CachedNetworkImageProvider(
                    ImageHelper.buildImage(notification.from.avatar)),
              )),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notification.title,
                    style: AppTextStyles.greenboldHeading,
                  ),
                  Text(
                    notification.description,
                  ),
                  Text("${'مرسل الإشعار : ' + notification.from.name}  ",
                      style: AppTextStyles.greyRegularDetail)
                ],
              ))
        ],
      ),
    );
  }
}
