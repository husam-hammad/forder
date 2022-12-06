// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/favorite_client.dart';
import 'package:flashorder/DataAccess/Models/favorite.dart';
import 'package:flashorder/DataAccess/Repository/favorite_repo.dart';
import 'package:get/get.dart';

import '../../DataAccess/Models/meal.dart';
import 'meals_controller.dart';

class FavoriteController extends GetxController {
  late FavoriteRepo repo;
  List<Favorite> favorites = [];
  late List<Meal> loadedMeals = [];
  late List<int> mealsIds = [];
  MealsController mealsController = Get.find();
  bool isloading = false;
  @override
  void onInit() async {
    super.onInit();
    await getAll();
  }

  Future<void> getAll() async {
    isloading = true;
    update();
    repo = FavoriteRepo(FavoriteClient());
    favorites = await repo.readAll();
    for (var favorite in favorites) {
      mealsIds.add(favorite.meal_id);
    }
    loadedMeals = await mealsController.getByIds(mealsIds);
    isloading = false;
    print("favorites : " + favorites.toString());
    update();
  }

  Meal? mealbyId(id) {
    try {
      return loadedMeals.where((element) => element.id == id).first;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteAll() async {
    repo = FavoriteRepo(FavoriteClient());
    repo.deleteAll();
    await getAll();
    update();
  }
}
