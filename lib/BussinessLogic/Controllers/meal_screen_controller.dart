// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../DataAccess/Models/favorite.dart';

class MealScreenController extends GetxController
    with GetTickerProviderStateMixin {
  FavoriteController controller = Get.find();
  CartController cartController = Get.find();
  MealsController mealsController = Get.find();
  UserController userController = Get.find();
  var oldmealcomponent = [];
  var newmealcompomemt = [];
  var animationscompleted = false.obs;
  var addbuttonEnabled = true;
  final Meal meal;
  var compomentController = TextEditingController();
  var numbercontroller = TextEditingController();
  bool isfav = false;
  late AnimationController animationController;

  bool canReplaceWtihPoint = false;
  var pointsCount = 0.0.obs;
  bool addingtocart = false;

  MealScreenController(this.meal);
  @override
  void onInit() async {
    numbercontroller.value = TextEditingValue(text: 1.toString());
    animationController = AnimationController(
      vsync: this,
    );
    if (meal.components.isNotEmpty) {
      oldmealcomponent.addAll(meal.components);
    }
    if (meal.components.isNotEmpty) {
      newmealcompomemt.addAll(meal.components);
    }

    if (double.parse(userController.points.value) > 0 &&
        meal.restaurent!.percentType != null &&
        meal.restaurent!.percentType != 1) {
      if (meal.price != 0 &&
          meal.price <=
              MyApp.pointcost * double.parse(userController.points.value)) {
        canReplaceWtihPoint = true;
        pointsCount.value = meal.price / MyApp.pointcost;
      }
    }
    print(oldmealcomponent);

    animationController.stop();
    await checkFav(meal.id);
    super.onInit();
  }

  /*  @override
  void onClose() {

    super.onClose();
  } */

  Future<void> checkFav(int mealId) async {
    for (var i = 0; i < controller.favorites.length; i++) {
      if (controller.favorites[i].meal_id == mealId) {
        isfav = true;
        update();
        return;
      }
    }
  }

  Future<void> toggle(Favorite favorite) async {
    if (await controller.repo.create(favorite)) {
      await controller.getAll();
      isfav = true;
      update();
    } else {
      await controller.repo.deleteByMeal(favorite.meal_id);
      await controller.getAll();
      isfav = false;
      update();
    }
    print(isfav);
    update();
  }

  void addNumber() {
    int number = int.parse(numbercontroller.value.text);
    number++;
    numbercontroller.value = TextEditingValue(text: number.toString());
    print(numbercontroller.value.toString());
    if (double.parse(userController.points.value) > 0 &&
        meal.restaurent!.percentType != null &&
        meal.restaurent!.percentType != 1) {
      if (meal.price * number <=
          MyApp.pointcost * double.parse(userController.points.value)) {
        canReplaceWtihPoint = true;
        pointsCount.value = meal.price / MyApp.pointcost * number;
      } else {
        canReplaceWtihPoint = false;
      }
    } else {
      canReplaceWtihPoint = false;
    }
    print(canReplaceWtihPoint);
    update();
  }

  void changeNumber(String value) {
    if (value != "") {
      int number = int.parse(numbercontroller.value.text);
      if (number > 0) {
        if (double.parse(userController.points.value) > 0 &&
            meal.restaurent!.percentType != null &&
            meal.restaurent!.percentType != 1) {
          if (meal.price * number <=
              MyApp.pointcost * double.parse(userController.points.value)) {
            canReplaceWtihPoint = true;
            pointsCount.value = meal.price / MyApp.pointcost * number;
          } else {
            canReplaceWtihPoint = false;
          }
        } else {
          canReplaceWtihPoint = false;
        }
        update();
      }
    } else {
      numbercontroller.value = TextEditingValue(text: value);
    }
  }

  void minusNumber() {
    int number = int.parse(numbercontroller.value.text);
    if (number > 1) {
      number--;
      numbercontroller.value = TextEditingValue(text: number.toString());
      if (double.parse(userController.points.value) > 0 &&
          meal.restaurent!.percentType != null &&
          meal.restaurent!.percentType != 1) {
        if (meal.price * number <=
            MyApp.pointcost * double.parse(userController.points.value)) {
          canReplaceWtihPoint = true;
          pointsCount.value = meal.price / MyApp.pointcost * number;
        } else {
          canReplaceWtihPoint = false;
        }
      } else {
        canReplaceWtihPoint = false;
      }
      update();
    }
  }

  void repartCompoment() {
    newmealcompomemt = [];
    newmealcompomemt.addAll(oldmealcomponent);
    update();
  }

  void deleteCompoment(index) {
    newmealcompomemt.removeAt(index);
    update();
  }

  Future<void> addToCart(replacedPoints) async {
    if (meal.isOpen.toString() == "1") {
      addingtocart = true;
      animationscompleted.value = false;

      addbuttonEnabled = false;
      update();
      int qty = int.parse(numbercontroller.value.text != ""
          ? numbercontroller.value.text
          : "0");
      if (qty > 0) {
        CartItem item = CartItem(
            id: 0,
            mealId: meal.id,
            restaurentId: meal.restaurent!.id,
            price: replacedPoints > 0
                ? 0
                : (meal.offerPrice > 0 ? meal.offerPrice : meal.price),
            allPrice:
                (meal.offerPrice > 0 ? meal.offerPrice : meal.price) * qty,
            qty: qty,
            compoments: newmealcompomemt.toString(),
            specialOrder: compomentController.value.text,
            replacedPoints: replacedPoints);

        await cartController.createItem(item);
        if (item.replacedPoints > 0) {
          userController.points.value =
              (num.parse(userController.points.value) - item.replacedPoints)
                  .toString();
        }
        animationscompleted.value = true;
        addbuttonEnabled = true;
        addingtocart = false;
        update();

        Get.rawSnackbar(
          duration: const Duration(seconds: 1),
          messageText: Text(
            "addtocartsuccessful".tr,
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: AppColors.green,
        );
        await animationController.forward();
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
    } else {
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: Text(
          "restaurentisclosed".tr,
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: Colors.redAccent,
      );
    }

    update();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
