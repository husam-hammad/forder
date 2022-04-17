// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../DataAccess/Models/favorite.dart';

class MealScreenController extends GetxController {
  FavoriteController controller = Get.find();
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
}
