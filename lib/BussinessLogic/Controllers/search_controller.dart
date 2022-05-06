import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final RestaurentController restaurentController = Get.find();
  final MealsController mealsController = Get.find();
  TextEditingController searchText = TextEditingController();

  List<Meal> searchedMeals = [];
  List<Restaurent> searchedRestaurent = [];
  Future<void> doSearch() async {
    if (searchText.value.text.isNotEmpty) {
      searchedMeals = mealsController.meals
          .where((element) =>
              element.name.contains(searchText.value.text) ||
              element.restaurent!.name.contains(searchText.value.text))
          .toList();
      searchedRestaurent = restaurentController.restaurents
          .where((element) => element.name.contains(searchText.value.text))
          .toList();
    } else {
      searchedMeals = [];
      searchedRestaurent = [];
    }
    update();
  }
}
