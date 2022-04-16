import 'package:flashorder/BussinessLogic/Providers/meal_client.dart';

import 'package:flashorder/DataAccess/Models/meal.dart';

import 'package:flashorder/DataAccess/Repository/meal_repo.dart';

import 'package:get/get.dart';

class MealsController extends GetxController {
  late MealRepo repo;
  List<Meal> meals = [];

  bool homeMealsLoaded = false;
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

  Meal? mealFromId(int id) {
    var result = meals.where((element) => element.id.isEqual(id)).toList();
    if (result.isNotEmpty) {
      return result[0];
    } else {
      return null;
    }
  }

  Future getMeals() async {
    repo = MealRepo(MealClient());
    await repo.getall().then((data) {
      meals = data;
      homeMealsLoaded = true;
      update();
    });
  }
}
