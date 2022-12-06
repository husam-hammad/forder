// ignore_for_file: avoid_print

import 'dart:convert';

/* import 'dart:math' as math; */
import 'package:collection/collection.dart';
import 'package:flashorder/BussinessLogic/Controllers/appbar_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/BussinessLogic/Providers/order_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_group.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/order_info.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';
import 'package:flashorder/DataAccess/Repository/cart_item_repo.dart';
import 'package:flashorder/main.dart';
/* import 'package:flashorder/helpers/calc.dart'; */
/* import 'package:flashorder/DataAccess/Repository/meal_repo.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../DataAccess/Models/meal.dart';
import '../../helpers/calc.dart';

class CartController extends GetxController with GetTickerProviderStateMixin {
  int? orderId;
  late List<CartItem> allcarts = [];
  RestaurentController restaurentController = Get.find();
  AppBarController appBarController = Get.find();
  MealsController mealsController = Get.find();
  CartItemRepo cartItemRepo = CartItemRepo();
  TextEditingController editQtyController = TextEditingController();
  PlacesController placesController = Get.find();
  OrderController orderController = Get.find();
  final UserController userController = Get.find();
  late Map<Restaurent?, List<CartItem>> groupedList;
  late Map<int, List<CartItem>> groupedListMap;
  late User? user;
  late List<CartGroup> cartgroup = [];
  var box = GetStorage();
  Rx<double> usedPoints = 0.0.obs;
  var isSending = false.obs;
  late List<int> mealsIds = [];
  late double orderlat = MyApp.userPosition!.latitude;
  late double orderlong = MyApp.userPosition!.longitude;
  late String orderAdress = userController.user!.adress!;
  late List<Meal> loadedMeals = [];
  late num totalValue = 0;
  var loadingMeals = false.obs;
  var locationSetBeforeSent = false.obs;
  late AnimationController animationController;
  @override
  onInit() async {
    animationController = AnimationController(
      vsync: this,
    );
    animationController.stop();
    super.onInit();
    if (restaurentController.restaurents.isEmpty) {
      await restaurentController.getResturents();
    }
  }

  Future<void> readAll(bool add) async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
    }

    allcarts = await cartItemRepo.readAll();

    for (var cartitem in allcarts) {
      cartitem.allPrice = cartitem.qty * cartitem.price;
      mealsIds.add(cartitem.mealId);
    }

    if (add) {
      loadingMeals.value = true;
      loadedMeals = await mealsController.getByIds(mealsIds);
      loadingMeals.value = false;
    }

    if (loadedMeals.isNotEmpty) {
      for (var cartitem in allcarts) {
        List<Meal>? loadedMealsList = loadedMeals
            .where((element) => element.id.isEqual(cartitem.mealId))
            .toList();
        if (loadedMealsList.isNotEmpty) {
          cartitem.meal = loadedMealsList[0];
        }
      }
    }

    groupedListMap = groupBy(allcarts, (cart) => cart.restaurentId);

    cartgroup.clear();
    totalValue = 0;
    update();
    groupedListMap.forEach((key, value) {
      num finalval = 0;
      num categoryDiscount = 0;
      num restaunretDiscount = 0;
      for (var item in value) {
        finalval += item.allPrice;
        if (item.meal!.categoryDiscount > 0) {
          categoryDiscount += (finalval * item.meal!.categoryDiscount) / 100;
        }
        if (item.meal!.restaurentDiscount > 0) {
          restaunretDiscount +=
              (finalval * item.meal!.restaurentDiscount) / 100;
        }
      }
      num finalvalWithtax = finalval;
      Restaurent? temprest = restaurentController.restaunretFromId(key);
      num taxs = 0;
      if (temprest != null && temprest.taxs != null) {
        for (var item in temprest.taxs!) {
          num taxval = item.taxValue;
          if (item.round == 10) {
            taxval = Calc.nearestTen(finalval * item.taxValue / 100);
          } else if (item.round == 100) {
            taxval = Calc.nearestHundred(finalval * item.taxValue / 100);
          } else if (item.round == 1000) {
            taxval = Calc.nearestThousand(finalval * item.taxValue / 100);
          }
          taxs += taxval;
        }
      }

      finalvalWithtax += taxs;
      finalvalWithtax += temprest!.getDeliveryCost();
      finalvalWithtax -= categoryDiscount;
      finalvalWithtax -= restaunretDiscount;

      if (temprest.addonValue != null && temprest.addonValue != 0) {
        num addonval =
            Calc.nearestHundred(finalval * temprest.addonValue! / 100);
        finalvalWithtax += addonval;
      }
      totalValue += Calc.nearestHundred(finalvalWithtax);
      cartgroup.add(CartGroup(
          restaurentId: key,
          cartItems: value,
          orderInfo: null,
          finalval: finalval,
          categoryDiscount: categoryDiscount,
          restaunretDiscount: restaunretDiscount));
    });

    update();
    appBarController.cartempty = allcarts.isEmpty;
    appBarController.update();
  }

  Future<void> orderToCart(UserOrder order) async {
    if (order.state.order < MyApp.allowEditState) {
      orderId = order.id;
      await deleteAll(false);
      for (var detail in order.details) {
        await createItem(CartItem(
            id: 0,
            mealId: detail.meal.id,
            restaurentId: order.restaurentId,
            qty: int.parse(detail.qty.toString()),
            price: detail.price,
            allPrice: detail.allPrice,
            specialOrder: detail.special,
            compoments: detail.compoments,
            replacedPoints: detail.replacedPoints!));
      }
      await readAll(true);
      Get.toNamed(
        AppRoutes.usercarts,
      );
    } else {
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: Text(
          "editordernot".tr,
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: Colors.redAccent,
      );
    }
  }

  Future<void> createItem(CartItem cartItem) async {
    await cartItemRepo.create(cartItem);
    await readAll(true);
    update();
  }

  void editItem(int oldId, int oldqty, BuildContext context) async {
    editQtyController.value = TextEditingValue(text: oldqty.toString());
    Get.defaultDialog(
      title: "",
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(5),
      content: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          color: Theme.of(context).backgroundColor,
          height: 200,
          child: Column(
            children: [
              Text(
                "editqty".tr,
                textAlign: TextAlign.right,
                style: AppTextStyles.greenboldHeading,
              ),
              const Divider(),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: editQtyController,
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: ElevatedButton(
                    style: CustomStyles.acceptButtonStyle,
                    onPressed: () async {
                      int qty = int.parse(editQtyController.value.text);
                      if (qty > 0) {
                        await cartItemRepo.update(oldId, qty);

                        await readAll(true);
                        Get.back();
                      } else {
                        Get.rawSnackbar(
                          duration: const Duration(seconds: 1),
                          messageText: Text(
                            "cannotbezeor".tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.whiteRegularHeading,
                          ),
                          backgroundColor: Colors.redAccent,
                        );
                      }
                    },
                    child: Text(
                      "edit".tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.whiteRegularDetail,
                    )),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  Future<void> deleteItem(CartItem cartItem) async {
    if (cartItem.replacedPoints > 0) {
      userController.points.value =
          (num.parse(userController.points.value) + cartItem.replacedPoints)
              .toString();
    }
    await cartItemRepo.deleteItem(cartItem.id);
    allcarts.remove(cartItem);
    update();
    await readAll(false);
  }

  Future<void> deleteAll(bool sending) async {
    if (!sending) {
      for (var item in allcarts) {
        if (item.replacedPoints > 0) {
          userController.points.value =
              (num.parse(userController.points.value) + item.replacedPoints)
                  .toString();
        }
      }
    }
    await cartItemRepo.deleteAll();
    allcarts.clear();
    update();
    await readAll(false);
    update();
  }

  Future<void> setPosition() async {
    await Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 350,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(
                      "sendtocurrentplace".tr,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.greyboldHeading,
                    ),
                    onTap: () {
                      orderlat = MyApp.userPosition!.latitude;
                      orderlong = MyApp.userPosition!.longitude;
                      locationSetBeforeSent.value = true;
                      update();
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                      itemCount: placesController.places.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            placesController.places[index].name,
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            orderlat = placesController.places[index].lat;
                            orderlong = placesController.places[index].long;
                            orderAdress = placesController.places[index].adress;
                            locationSetBeforeSent.value = true;
                            update();
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ]),
          ),
        ),
        shape:
            const RoundedRectangleBorder(borderRadius: CustomStyles.raduis100),
        elevation: 2.5,
        backgroundColor: Colors.white,
        isDismissible: false,
        isScrollControlled: true);
  }

  void sendBox(var boxid) async {
    if (userController.user != null) {
      await setPosition();
      if (locationSetBeforeSent.value == true) {
        isSending.value = true;

        OrderClient client = OrderClient();
        bool isSent = await client.sendBox(json.encode(<String, dynamic>{
          "user_id": user!.id,
          "box_id": boxid,
        }));
        if (isSent) {
          Get.rawSnackbar(
            duration: const Duration(seconds: 1),
            messageText: Text(
              'sendordersuccessful'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.whiteRegularHeading,
            ),
            backgroundColor: AppColors.green,
          );
          orderId = null;
          locationSetBeforeSent.value = false;

          //animationController.reset();
          update();
        } else {
          Get.rawSnackbar(
            duration: const Duration(seconds: 1),
            messageText: Text(
              "errorinsend".tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.whiteRegularHeading,
            ),
            backgroundColor: Colors.redAccent,
          );
        }
        isSending.value = false;
      }
    } else {
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: Text(
          "pleaselogin".tr,
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: Colors.redAccent,
      );
    }
    animationController.reset();
  }

  void sendorder() async {
    if (userController.user != null) {
      await setPosition();
      if (locationSetBeforeSent.value == true) {
        isSending.value = true;
        for (var item in cartgroup) {
          num singleOrdeValue = 0;
          num singleOrdepoints = 0;
          for (var cart in item.cartItems) {
            cart.price = cart.meal!.price;
            cart.allPrice = cart.price * cart.qty;
            singleOrdeValue += cart.allPrice;
            singleOrdepoints += cart.replacedPoints;
          }
          Restaurent? temprest =
              restaurentController.restaunretFromId(item.restaurentId!);

          item.orderInfo = OrderInfo(
              userId: user!.id,
              restaurentId: item.restaurentId!,
              pLat: orderlat,
              pLong: orderlong,
              orderValue: singleOrdeValue,
              deliveryCost: temprest!.getDeliveryCost(),
              adress: orderAdress,
              usedpoints: singleOrdepoints);
        }
        OrderClient client = OrderClient();
        bool isSent = await client.sendOrder(jsonEncode(cartgroup), orderId);
        if (isSent) {
          await animationController.forward();
          await deleteAll(true);
          await orderController.getAll();
          Get.rawSnackbar(
            duration: const Duration(seconds: 1),
            messageText: Text(
              'sendordersuccessful'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.whiteRegularHeading,
            ),
            backgroundColor: AppColors.green,
          );
          orderId = null;
          locationSetBeforeSent.value = false;

          //animationController.reset();
          update();
        } else {
          Get.rawSnackbar(
            duration: const Duration(seconds: 1),
            messageText: Text(
              "errorinsend".tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.whiteRegularHeading,
            ),
            backgroundColor: Colors.redAccent,
          );
        }
        isSending.value = false;
      }
    } else {
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: Text(
          "pleaselogin".tr,
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: Colors.redAccent,
      );
    }
    animationController.reset();
  }

  @override
  void onReady() async {
    if (restaurentController.restaurents.isEmpty) {
      await restaurentController.getResturents();
    }
    await readAll(true);
    await userController.getPoints();
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
