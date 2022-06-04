// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.pink2,
                          borderRadius: CustomStyles.raduis50),
                      child: const Text(
                        "كابتن التوصيل",
                        style: AppTextStyles.whiteboldHeading,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.lightwhite,
                        borderRadius: CustomStyles.raduis50,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              ImageHelper.buildImage(captin.avatar),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.lightwhite,
                          borderRadius: CustomStyles.raduis50),
                      child: Text(
                        captin.name,
                        style: AppTextStyles.pinkboldHeading,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: AppColors.lightwhite,
                          borderRadius: CustomStyles.raduis50),
                      child: Text(
                        captin.phone,
                        style: AppTextStyles.greenRegularHeading,
                        textAlign: TextAlign.center,
                      ),
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
