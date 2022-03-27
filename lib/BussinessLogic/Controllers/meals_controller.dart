import 'package:flashorder/BussinessLogic/Providers/meal_client.dart';

import 'package:flashorder/DataAccess/Models/meal.dart';

import 'package:flashorder/DataAccess/Repository/meal_repo.dart';

import 'package:get/get.dart';

class MealsController extends GetxController {
  late MealRepo repo;
  List<Meal> meals = [];

  var selectedindex = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getMeals();
  }

  void deleteCompoment(mealindex, comindex) {
    meals[int.parse(mealindex.toString())].components.removeAt(comindex);
    update();
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
