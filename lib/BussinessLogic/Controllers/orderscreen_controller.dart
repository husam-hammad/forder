// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/captin.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';
//import 'package:flashorder/Presenttion/Screens/googlemap_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/////////import '../../Presenttion/Screens/map_screen.dart';

class OrderScreenController extends GetxController {
  final OrderController orderController = Get.find();

  final String? orderid;
  UserOrder? order;
  var orderLodaded = false.obs;
  OrderScreenController(this.orderid);

  @override
  void onInit() async {
    super.onInit();
    await orderController.getAll();
    refresh();
  }

  @override
  void onReady() {
    super.onReady();

    order = orderController.userOrderFormID(int.parse(orderid!));
    update();
    orderLodaded.value = true;
    print("showcaptin -- :" + Get.parameters["showcaptin"].toString());
    if (Get.parameters["showcaptin"] == "1") {
      print("showing captin");

      showCaptinInfo(order!.captin!);
    }
    update();
  }

  @override
  void onClose() async {
    super.onClose();
    await stopSendLocation();
  }

  Future<void> requirelocation() async {
    UserClient userClient = UserClient();
    UserController userController = Get.find();
    await userClient.requireLocation(
        userController.user!.token, order!.captin!.id, userController.user!.id);
    print("CAAAAAAAAAAAAAAAPTIN");
    print(order!.captin!);
    Get.toNamed(AppRoutes.mapscreen, arguments: [order!.captin!]);
  }

  Future<void> stopSendLocation() async {
    UserClient userClient = UserClient();
    UserController userController = Get.find();
    if (order!.captin != null) {
      await userClient.stopSendLocation(userController.user!.token,
          order!.captin!.id, userController.user!.id);
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
                      child: Text(
                        "captin".tr,
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
                    InkWell(
                      onTap: () {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: captin.phone,
                        );
                        launchUrl(launchUri);
                      },
                      child: Container(
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
