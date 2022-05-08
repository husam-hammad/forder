// ignore_for_file: avoid_print

/* import 'dart:convert';
 */

import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
/* import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Widgets/cart_item.dart'; */
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/cart_item.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCart extends StatelessWidget {
  UserCart({Key? key}) : super(key: key);
  final MealsController mealsController = Get.find();
  final RestaurentController restaurentController = Get.find();
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: buildCartNav(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "سلة الشراء",
                    style: AppTextStyles.pinkboldHeading,
                  ),
                  InkWell(
                    onTap: () async {
                      await cartController.deleteAll();
                    },
                    child: const Text(
                      "حذف الكل",
                      style: AppTextStyles.greyregular,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 500,
              width: double.infinity,
              child: GetBuilder(
                  init: cartController,
                  builder: (_) {
                    return ListView.builder(
                        itemCount: cartController.cartgroup.length,
                        itemBuilder: (_, index) {
                          Restaurent? restaurent = restaurentController
                              .restaunretFromId(cartController
                                  .cartgroup[index].restaurentId!);
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.restaurant,
                                          size: 20,
                                          color: AppColors.pink2,
                                        ),
                                        Text(
                                          restaurent!.name,
                                          textAlign: TextAlign.right,
                                          style:
                                              AppTextStyles.pinkRegularHeading,
                                        )
                                      ],
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                          text: " كلفة التوصيل : ",
                                          style: AppTextStyles.greyBoldDetail),
                                      TextSpan(
                                          text: restaurent.deliveryCost
                                              .toString(),
                                          style:
                                              AppTextStyles.greyRegularDetail)
                                    ]))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: cartController
                                        .cartgroup[index].cartItems.length *
                                    90,
                                child: ListView.builder(
                                    itemCount: cartController
                                        .cartgroup[index].cartItems.length,
                                    itemBuilder: (_, index2) {
                                      CartItem cartItem = cartController
                                          .cartgroup[index].cartItems[index2];
                                      Meal? meal = mealsController
                                          .mealFromId(cartItem.mealId);
                                      cartItem.meal = meal;

                                      return CartItemWidget(cartItem: cartItem);
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider()
                            ],
                          );
                          /* CartItem cartItem = cartController.allcarts[index];
                          Meal? meal =
                              mealsController.mealFromId(cartItem.mealId);
                          cartItem.meal = meal;

                          return CartItemWidget(cartItem: cartItem); */
                        });
                  }),
            )
          ],
        ),
      ),
    ));
  }

  Widget buildCartNav() {
    return GetBuilder(
        init: cartController,
        builder: (_) {
          if (cartController.allcarts.isNotEmpty) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(7),
              child: ElevatedButton(
                  style: CustomStyles.acceptButtonStyle,
                  onPressed: () {
                    cartController.sendorder();

                    /* var parsedd = jsonEncode(cartController.allcarts /* .toList() */);

            print(jsonDecode(parsedd)); */
                  },
                  child: Obx(() {
                    if (!cartController.isSending.value) {
                      return const Text("إرسال الطلب");
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(strokeWidth: 1),
                          SizedBox(
                            width: 5,
                          ),
                          Text("جاري الإرسال")
                        ],
                      );
                    }
                  })),
            );
          } else {
            return Row();
          }
        });
  }
}
