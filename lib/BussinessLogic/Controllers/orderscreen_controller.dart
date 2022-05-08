import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';
import 'package:flashorder/helpers/image_helper.dart';

import 'package:flutter/cupertino.dart';
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
