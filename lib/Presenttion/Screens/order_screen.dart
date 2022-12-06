import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
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
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd hh:mm');

  final OrderScreenController controller =
      Get.put(OrderScreenController(Get.parameters["order"]));
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: GetBuilder(
          init: controller,
          builder: (_) {
            if (controller.orderLodaded.value == false) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  controller.onReady();
                },
                child: SizedBox(
                  height: Get.height,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'orderid'.tr + "${controller.order!.id} ",
                              style: AppTextStyles.pinkboldTopPage,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height - 200,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            controller.onReady();
                          },
                          child: ListView(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Center(
                                  child: Column(
                                    children: [
                                      controller.order!.state.image != ""
                                          ? CachedNetworkImage(
                                              imageUrl: ImageHelper.buildImage(
                                                  controller
                                                      .order!.state.image),
                                              width: 100,
                                              fit: BoxFit.contain,
                                            )
                                          : Row(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                ColorHelper.fromHex(controller
                                                    .order!.state.color),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            controller.order!.state.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
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
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "captin".tr,
                                      style: AppTextStyles.greenboldHeading,
                                    ),
                                    if (controller.order!.captin != null)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                  onTap: () {
                                                    controller.showCaptinImage(
                                                        controller.order!
                                                            .captin!.avatar);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.green,
                                                    radius: 30,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              45),
                                                      child: CachedNetworkImage(
                                                        width: 50,
                                                        height: 50,
                                                        imageUrl: ImageHelper
                                                            .buildImage(
                                                                controller
                                                                    .order!
                                                                    .captin!
                                                                    .avatar),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        controller.order!
                                                            .captin!.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .apply(
                                                                color: AppColors
                                                                    .green),
                                                      ),
                                                      Text(
                                                        controller.order!
                                                            .captin!.phone,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                            if (controller
                                                    .order!.captin!.phone !=
                                                "")
                                              Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        final Uri launchUri =
                                                            Uri(
                                                          scheme: 'tel',
                                                          path: controller
                                                              .order!
                                                              .captin
                                                              ?.phone,
                                                        );
                                                        launchUrl(launchUri);
                                                      },
                                                      icon: const Icon(
                                                        Icons.call,
                                                        color:
                                                            Colors.blueAccent,
                                                        size: 35,
                                                      ))),
                                            if (controller.order!.state.id == 3)
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.room,
                                                    color: AppColors.pink,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    controller
                                                        .requirelocation();
                                                  },
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    if (controller.order!.captin == null)
                                      Text(
                                        "لم يتم التعيين",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "orderdetails".tr,
                                      style: AppTextStyles.greenboldHeading,
                                    ),
                                    SizedBox(
                                      height:
                                          controller.order!.details.length * 50,
                                      child: ListView.builder(
                                        itemCount:
                                            controller.order!.details.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              "• ${controller.order!.details[index].allInOne}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
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
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Row(
                                  children: [
                                    Text(
                                      "ordercost".tr + " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      controller.order!.value.toString() +
                                          "sp".tr,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Row(
                                  children: [
                                    Text(
                                      "deliverycost".tr + " : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      controller.order!.deliverycost
                                              .toString() +
                                          "sp".tr,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Row(
                                  children: [
                                    Text(
                                      "finalvalue".tr + " : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      (controller.order!.deliverycost +
                                                  controller.order!.value)
                                              .toString() +
                                          "sp".tr,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: CustomStyles.raduis100),
                                child: Row(
                                  children: [
                                    Text(
                                      "createdat".tr + " ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      formatter
                                          .format(controller.order!.createdAt!),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            }
          },
        ),
      ),
    ));
  }
}
