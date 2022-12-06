// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../Providers/local_notification_service.dart';

class OrderRatingController extends GetxController {
  final TextEditingController paidAmount = TextEditingController();

//For Rating Dialog
  late int orderRatingId;
  late int captinRatingId;
  late int restaurentRatingId;
  late String captinRatingName = "";
  late String restaurentRatingName = "";
  final UserController userController = Get.find();
  var ratingSendingState = false.obs;
  late double captinRating = 0;
  late double restaurentRating = 0;

  Future<void> sendRating() async {
    UserClient userClient = UserClient();
    ratingSendingState.value = true;
    await userClient.sendOrderRating(orderRatingId, restaurentRatingId,
        restaurentRating, captinRatingId, captinRating, paidAmount.text);
    Get.back();
    ratingSendingState.value = false;
  }

  onRestaurentUpate(rating) {
    restaurentRating = rating;
    print(rating);
    update();
  }

  onCaptinUpate(rating) {
    captinRating = rating;
    print(rating);
    update();
  }

  /* @override
  void onInit() async {
    super.onInit();
    var details = await NotificationService()
        .flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      print(details.payload);
    }
    if (Get.parameters["showratingdialog"] == "1") {
      orderRatingId = int.parse(Get.parameters["order_id"]!);
      captinRatingId = int.parse(Get.parameters["captin_id"]!);
      restaurentRatingId = int.parse(Get.parameters["restaurent_id"]!);
      print(Get.parameters);
      update();
    }
  } */

  @override
  void onInit() {
    if (Get.parameters["showratingdialog"] == "1") {
      orderRatingId = int.parse(Get.parameters["order_id"]!);
      captinRatingId = int.parse(Get.parameters["captin_id"]!);
      restaurentRatingId = int.parse(Get.parameters["restaurent_id"]!);

      captinRatingName = Get.parameters["captin_name"]!;
      restaurentRatingName = Get.parameters["restaurent_name"]!;

      update();
    }
    super.onInit();
  }
}
