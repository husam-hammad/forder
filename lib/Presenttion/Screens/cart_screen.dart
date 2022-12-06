// ignore_for_file: avoid_print

/* import 'dart:convert';
 */

import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/connectivity_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
/* import 'package:flashorder/DataAccess/Models/meal.dart'; */
import 'package:flashorder/DataAccess/Models/restaurent.dart';
/* import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Widgets/cart_item.dart'; */
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/cart_item.dart';
import 'package:flashorder/Presenttion/Widgets/loading_item.dart';
import 'package:flashorder/Presenttion/Widgets/noconnection.dart';
import 'package:flashorder/helpers/calc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserCart extends StatelessWidget {
  UserCart({Key? key}) : super(key: key);
  final MealsController mealsController = Get.find();
  final RestaurentController restaurentController = Get.find();
  final CartController cartController = Get.find();
  final ConnectivityController connectivityController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder(
            init: connectivityController,
            builder: (_) {
              return Directionality(
                textDirection: Get.locale!.languageCode == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: !connectivityController.connected
                    ? const NoConnection()
                    : Scaffold(
                        appBar: buildAppBar(),
                        bottomNavigationBar: buildCartNav(),
                        resizeToAvoidBottomInset: false,
                        body: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cartController.orderId != null
                                      ? "editorder".tr
                                      : "mycart".tr,
                                  style: AppTextStyles.pinkboldTopPage,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await cartController.deleteAll(false);
                                  },
                                  child: Text(
                                    "deleteall".tr,
                                    style: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppTextStyles.whiteRegularDetail
                                        : AppTextStyles.greyregular,
                                  ),
                                )
                              ],
                            ),
                          ),
                          RefreshIndicator(
                            onRefresh: () async {
                              cartController.onReady();
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  height: 520,
                                  width: double.infinity,
                                  child: GetBuilder(
                                      init: cartController,
                                      builder: (_) {
                                        return restaurentController
                                                    .restaurents.isEmpty &&
                                                cartController
                                                    .loadingMeals.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : ListView.builder(
                                                itemCount: cartController
                                                    .cartgroup.length,
                                                itemBuilder: (_, index) {
                                                  Restaurent? restaurent =
                                                      restaurentController
                                                          .restaunretFromId(
                                                              cartController
                                                                  .cartgroup[
                                                                      index]
                                                                  .restaurentId!);

                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .restaurant,
                                                                  size: 20,
                                                                  color:
                                                                      AppColors
                                                                          .pink2,
                                                                ),
                                                                Text(
                                                                  restaurent!
                                                                      .name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: AppTextStyles
                                                                      .pinkRegularHeading,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: cartController
                                                                .cartgroup[
                                                                    index]
                                                                .cartItems
                                                                .length *
                                                            90,
                                                        child: ListView.builder(
                                                            itemCount:
                                                                cartController
                                                                    .cartgroup[
                                                                        index]
                                                                    .cartItems
                                                                    .length,
                                                            itemBuilder:
                                                                (_, index2) {
                                                              CartItem
                                                                  cartItem =
                                                                  cartController
                                                                      .cartgroup[
                                                                          index]
                                                                      .cartItems[index2];
                                                              /*  Meal? meal =
                                                                      mealsController
                                                                          .mealFromId(
                                                                              cartItem
                                                                                  .mealId);
                                                                  cartItem.meal =
                                                                      meal; */

                                                              return CartItemWidget(
                                                                  cartItem:
                                                                      cartItem);
                                                            }),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5,
                                                                horizontal: 10),
                                                        child: Column(
                                                          children: [
                                                            if (restaurent
                                                                    .taxs !=
                                                                null)
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 3,
                                                                      child: buildtax(
                                                                          restaurent
                                                                              .taxs!,
                                                                          cartController
                                                                              .cartgroup[
                                                                                  index]
                                                                              .finalval,
                                                                          restaurent
                                                                              .deliveryCost,
                                                                          restaurent
                                                                              .addonValue,
                                                                          cartController
                                                                              .cartgroup[
                                                                                  index]
                                                                              .categoryDiscount,
                                                                          cartController
                                                                              .cartgroup[index]
                                                                              .restaunretDiscount)),
                                                                  Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Row())
                                                                ],
                                                              ),
                                                          ],
                                                        ),
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
                                ),
                                Positioned(
                                    bottom: 30,
                                    child: LottieBuilder.asset(
                                      'assets/images/rocket.json',
                                      frameRate: FrameRate.max,
                                      width: Get.width,
                                      controller:
                                          cartController.animationController,
                                      onLoaded: (composition) {
                                        // Configure the AnimationController with the duration of the
                                        // Lottie file and start the animation.
                                        cartController.animationController
                                          ..duration = composition.duration
                                          //;const Duration(microseconds: 200)
                                          ..stop();
                                      },
                                    )),
                              ],
                            ),
                          ),
                          GetBuilder(
                              init: cartController,
                              builder: (_) {
                                return cartController.allcarts.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "total".tr + " : ",
                                              style:
                                                  AppTextStyles.pinkboldHeading,
                                            ),
                                            Text(
                                              cartController.totalValue
                                                  .toStringAsFixed(0),
                                              style:
                                                  AppTextStyles.pinkboldHeading,
                                            )
                                          ],
                                        ),
                                      )
                                    : Row();
                              })
                        ]),
                      ),
              );
            }));
  }

  Widget buildtax(taxs, num finalvalue, num delivercost, num? addonvalue,
      num categorydiscount, num restaurentDiscount) {
    num taxes = 0;
    List<Widget> names = [];
    List<Widget> values = [];

    names.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "إجمالي الطلب :",
          style: AppTextStyles.greenRegularTitle,
          textAlign: TextAlign.start,
        ),
      ],
    ));
    values.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (finalvalue).toStringAsFixed(0),
          textAlign: TextAlign.start,
        )
      ],
    ));
    names.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "كلفة التوصيل :",
          style: AppTextStyles.greenRegularTitle,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    ));
    values.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (delivercost).toStringAsFixed(0),
          textAlign: TextAlign.start,
        )
      ],
    ));
    if (addonvalue != null) {
      taxes += Calc.nearestHundred(finalvalue * addonvalue / 100);
      names.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            " اجور خدمة : ",
            style: AppTextStyles.greenRegularTitle,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ));
      values.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (Calc.nearestHundred(finalvalue * addonvalue / 100))
                .toStringAsFixed(0),
            textAlign: TextAlign.start,
          )
        ],
      ));
    }
    for (var item in taxs) {
      num taxval = 0;
      if (item.round == 10) {
        taxval = Calc.nearestTen(finalvalue * item.taxValue / 100);
      } else if (item.round == 100) {
        taxval = Calc.nearestHundred(finalvalue * item.taxValue / 100);
      } else if (item.round == 1000) {
        taxval = Calc.nearestThousand(finalvalue * item.taxValue / 100);
      }
      taxes += taxval;
      names.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name + ":",
            style: AppTextStyles.greenRegularTitle,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ));
      values.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(taxval.toStringAsFixed(0), textAlign: TextAlign.right)],
      ));
    }

    if (categorydiscount > 0) {
      names.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " حسم الوجبة : ",
            style: AppTextStyles.greenRegularTitle.apply(color: Colors.red),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ));
      values.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Calc.nearestHundred(categorydiscount).toStringAsFixed(0),
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ));
    }
    if (restaurentDiscount > 0) {
      names.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " حسم المطعم : ",
            style: AppTextStyles.greenRegularTitle.apply(color: Colors.red),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ));
      values.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Calc.nearestHundred(restaurentDiscount).toStringAsFixed(0),
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ));
    }
    names.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          " القيمة الصافية : ",
          style: AppTextStyles.greenboldHeading,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    ));
    values.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (finalvalue +
                  delivercost +
                  taxes -
                  categorydiscount -
                  restaurentDiscount)
              .toStringAsFixed(0),
          textAlign: TextAlign.right,
        )
      ],
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: names,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: values,
        )
      ],
    );
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
                      return Text(
                        cartController.orderId != null
                            ? "editorder".tr
                            : "sendorder".tr,
                        style: AppTextStyles.whiteRegularHeading,
                      );
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loadingItem(),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "sending".tr,
                            style: AppTextStyles.whiteRegularHeading,
                          )
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
