// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../DataAccess/Models/favorite.dart';

class MealScreenController extends GetxController {
  FavoriteController controller = Get.find();
  CartController cartController = Get.find();
  MealsController mealsController = Get.find();
  var addbuttonEnabled = RxBool(true);
  final Meal meal;
  var compomentController = TextEditingController();
  var numbercontroller = TextEditingController();
  bool isfav = false;

  MealScreenController(this.meal);

  @override
  void onInit() async {
    super.onInit();
    numbercontroller.value = TextEditingValue(text: 1.toString());
    await checkFav(meal.id);
  }

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
    } else {
      await controller.repo.deleteByMeal(favorite.meal_id);
      await controller.getAll();
      isfav = false;
    }

    update();
  }

  void addNumber() {
    int number = int.parse(numbercontroller.value.text);
    number++;
    numbercontroller.value = TextEditingValue(text: number.toString());
  }

  void minusNumber() {
    int number = int.parse(numbercontroller.value.text);
    if (number > 1) {
      number--;
      numbercontroller.value = TextEditingValue(text: number.toString());
    }
  }

  Future<void> addToCart() async {
    addbuttonEnabled.value = false;
    int qty = int.parse(numbercontroller.value.text);
    CartItem item = CartItem(
        id: 0,
        mealId: meal.id,
        restaurentId: meal.restaurent!.id,
        price: 0,
        allPrice: 0,
        qty: qty,
        specialOrder: compomentController.value.text);

    await cartController.createItem(item);

    Get.rawSnackbar(
      duration: const Duration(seconds: 1),
      messageText: const Text(
        "تمت الإضافة بنجاح",
        textAlign: TextAlign.center,
        style: AppTextStyles.whiteRegularHeading,
      ),
      backgroundColor: AppColors.green,
    );
    addbuttonEnabled.value = true;
  }
}
