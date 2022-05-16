// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/captin.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';
import 'package:flashorder/helpers/image_helper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  final OrderController orderController = Get.find();
  final String? orderid;
  late UserOrder order;

  OrderScreenController(this.orderid);
  @override
  void onInit() {
    super.onInit();
    order = orderController.userOrderFormID(int.parse(orderid!));
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.parameters["showcaptin"] == "1") {
      showCaptinInfo(order.captin!);
    }
  }

  void showCaptinInfo(Captin captin) {
    Get.dialog(
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "كابتن التوصيل",
                      style: AppTextStyles.pinkboldHeading,
                    ),
                    CachedNetworkImage(
                      imageUrl: ImageHelper.buildImage(captin.avatar),
                      fit: BoxFit.contain,
                    ),
                    Text(
                      captin.name,
                      style: AppTextStyles.pinkboldHeading,
                    ),
                    Text(
                      captin.phone,
                      style: AppTextStyles.greenRegularHeading,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        transitionCurve: Curves.easeInCubic);
  }

  void showCaptinImage(image) {
    Get.dialog(
        Container(
            padding: const EdgeInsets.all(20),
            child: CachedNetworkImage(
              imageUrl: ImageHelper.buildImage(image),
              fit: BoxFit.contain,
            )),
        transitionCurve: Curves.easeInCubic);
  }
}
