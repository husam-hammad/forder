import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
/* import 'package:flashorder/Constants/colors.dart'; */
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  final OrderController orderController = Get.find();
  final UserController userController = Get.find();
  void getOrders() async {
    await orderController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return SafeArea(
        child: Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
                appBar: buildAppBar(),
                bottomNavigationBar: const CustomBotttomNav(),
                body: GetBuilder(
                    init: userController,
                    builder: (_) {
                      return userController.user == null
                          ? Center(
                              child: Text("pleaselogin".tr),
                            )
                          : Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "orders".tr,
                                      style: AppTextStyles.pinkboldTopPage,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        /* await orderController.loadMore(); */
                                      },
                                      child: const Text(
                                        "عرض الكل",
                                        style: AppTextStyles.greyregular,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: Get.height - 215,
                                width: double.infinity,
                                child: GetBuilder(
                                    init: orderController,
                                    builder: (_) {
                                      if (orderController.ordersLoaded) {
                                        return RefreshIndicator(
                                          onRefresh: () async {
                                            orderController.getAll();
                                          },
                                          child: ListView.builder(
                                            itemCount:
                                                orderController.orders.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: (() {
                                                  orderController.gotoOrder(
                                                      orderController
                                                          .orders[index].id);
                                                }),
                                                child: ListTile(
                                                  isThreeLine: true,
                                                  style: ListTileStyle.list,
                                                  leading: CircleAvatar(
                                                    radius: 40,
                                                    backgroundColor:
                                                        ColorHelper.fromHex(
                                                            orderController
                                                                .orders[index]
                                                                .state
                                                                .color),
                                                    child: Text(
                                                      orderController
                                                          .orders[index].id
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  title: Text('orderid'.tr +
                                                      "${orderController.orders[index].id}"),
                                                  subtitle: Text('orderstate'
                                                          .tr +
                                                      " ${orderController.orders[index].state.name}"),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              )
                            ]);
                    }))));
  }
}
