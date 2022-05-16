import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';

import 'package:flashorder/BussinessLogic/Controllers/orderscreen_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/helpers/color_helper.dart';
import 'package:flashorder/helpers/image_helper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as ints;

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd hh:mm');

  final OrderScreenController controller =
      Get.put(OrderScreenController(Get.parameters["order"]));

  @override
  Widget build(BuildContext context) {
    final checkordercontrollerexist = Get.isRegistered<OrderController>();
    if (!checkordercontrollerexist) {
      Get.put(OrderController());
    }

    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightwhite,
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الطلب رقم :  ${controller.order.id} ",
                  style: AppTextStyles.pinkboldTopPage,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: Get.height - 210,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: CustomStyles.raduis100),
                  child: Center(
                    child: Column(
                      children: [
                        controller.order.state.image != ""
                            ? CachedNetworkImage(
                                imageUrl: ImageHelper.buildImage(
                                    controller.order.state.image),
                                width: 100,
                                fit: BoxFit.contain,
                              )
                            : Row(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: ColorHelper.fromHex(
                                  controller.order.state.color),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              controller.order.state.name,
                              style: AppTextStyles.greyboldHeading,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: CustomStyles.raduis100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "الكابتن : ",
                        style: AppTextStyles.greenboldHeading,
                      ),
                      Row(
                        children: [
                          controller.order.captin != null
                              ? Expanded(
                                  child: ListTile(
                                    title: Text(
                                      controller.order.captin!.name,
                                      style: AppTextStyles.greyBoldDetail,
                                    ),
                                    subtitle: Text(
                                      controller.order.captin!.phone,
                                      style: AppTextStyles.greyregular,
                                    ),
                                    leading: InkWell(
                                      onTap: () {
                                        controller.showCaptinImage(
                                            controller.order.captin!.avatar);
                                      },
                                      child: CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  ImageHelper.buildImage(
                                                      controller.order.captin!
                                                          .avatar))),
                                    ),
                                  ),
                                )
                              : const Text("لم يتم التعيين")
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: CustomStyles.raduis100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "تفاصيل الطلب",
                        style: AppTextStyles.greenboldHeading,
                      ),
                      SizedBox(
                        height: controller.order.details.length * 50,
                        child: ListView.builder(
                          itemCount: controller.order.details.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                "• ${controller.order.details[index].allInOne}",
                                style: AppTextStyles.greyRegularDetail,
                                textAlign: TextAlign.right,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: CustomStyles.raduis100),
                  child: Row(
                    children: [
                      const Text(
                        "تكلفةالطلب : ",
                        style: AppTextStyles.greenboldHeading,
                      ),
                      Text(
                        controller.order.value.toString() + " ليرة سورية",
                        style: AppTextStyles.greyregular,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: CustomStyles.raduis100),
                  child: Row(
                    children: [
                      const Text(
                        "تكلفة التوصيل : ",
                        style: AppTextStyles.greenboldHeading,
                      ),
                      Text(
                        controller.order.deliverycost.toString() +
                            " ليرة سورية",
                        style: AppTextStyles.greyregular,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: CustomStyles.raduis100),
                  child: Row(
                    children: [
                      const Text(
                        "تاريخ الإنشاء : ",
                        style: AppTextStyles.greenboldHeading,
                      ),
                      Text(
                        formatter.format(controller.order.createdAt!),
                        style: AppTextStyles.greyregular,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    ));
  }
}
