import 'package:flashorder/BussinessLogic/Providers/meal_client.dart';

import 'package:flashorder/DataAccess/Models/meal.dart';

import 'package:flashorder/DataAccess/Repository/meal_repo.dart';

import 'package:get/get.dart';

class MealsController extends GetxController {
  late MealRepo repo;
  List<Meal> meals = [];

  @override
  void onInit() async {
    super.onInit();
    await getMeals();
  }

  Future getMeals() async {
    repo = MealRepo(MealClient());
    await repo.getall().then((data) {
      meals = data;
      // ignore: avoid_print
      print(meals);
      update();
    });
  }
}
