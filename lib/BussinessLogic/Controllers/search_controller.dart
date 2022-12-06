// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helpers/debouncer.dart';

class SearchController extends GetxController {
  final RestaurentController restaurentController = Get.find();
  final MealsController mealsController = Get.find();
  TextEditingController searchText = TextEditingController();
  var searching = false.obs;
  List<Meal> searchedMeals = [];
  List<Restaurent> searchedRestaurent = [];
  final debouncer = Debouncer();
  Future<void> doSearch() async {
    searching.value = true;
    update();
    if (searchText.value.text.isNotEmpty) {
      await mealsController.getSearch(searchText.value.text);
      searchedMeals = mealsController.searchedMeals;

/* 
      searchedMeals = mealsController.meals
          .where((element) =>
              element.name.contains(searchText.value.text) ||
              element.restaurent!.name.contains(searchText.value.text))
          .toList(); */
      searchedRestaurent = restaurentController.restaurents
          .where((element) => element.name.contains(searchText.value.text))
          .toList();
      searching.value = false;
      update();
    } else {
      searchedMeals = [];
      searchedRestaurent = [];
    }
    update();
  }
}
