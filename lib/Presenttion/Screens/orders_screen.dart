import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: buildAppBar(),
                bottomNavigationBar: const CustomBotttomNav(),
                body: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "الطلبات ",
                          style: AppTextStyles.pinkboldHeading,
                        ),
                        InkWell(
                          onTap: () async {
                            /* await cartController.deleteAll(); */
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
                    height: Get.height - 200,
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
                                itemCount: orderController.orders.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: (() {
                                      orderController.gotoOrder(
                                          orderController.orders[index].id);
                                    }),
                                    child: ListTile(
                                      isThreeLine: true,
                                      style: ListTileStyle.list,
                                      leading: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: ColorHelper.fromHex(
                                            orderController
                                                .orders[index].state.color),
                                        child: Text(
                                          orderController.orders[index].id
                                              .toString(),
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      title: Text(
                                          "طلب رقم :  ${orderController.orders[index].id}"),
                                      subtitle: Text(
                                          "الحالة :  ${orderController.orders[index].state.name}"),
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
                ]))));
  }
}
