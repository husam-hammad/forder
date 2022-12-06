// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/meal_client.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/DataAccess/Repository/meal_repo.dart';
import 'package:get/get.dart';

class MealsController extends GetxController {
  late MealRepo repo;
  List<Meal> featuredmeals = [];
  List<Meal> offersmeals = [];
  List<Meal> meals = [];
  List<Meal> searchedMeals = [];
  bool homeMealsLoaded = false;
  bool offersMealsLoaded = false;

  List<Meal> oppenedmeals = [];
  var selectedindex = 0.obs;
  var isloading = false.obs;
  var mealsEnded = false.obs;
  int page = 1;
  var showgetmore = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getFeaturedMeals();
    await getOffersMeals();
    await getMeals();
  }

  Future<List<Meal>> getByIds(List<int> ids) async {
    repo = MealRepo(MealClient());
    var parsedids = "";
    for (var item in ids) {
      parsedids += item.toString() + ",";
    }

    List<Meal> mealsbyid = await repo.mealsbyids(parsedids);

    if (mealsbyid.isNotEmpty) {
      return mealsbyid;
    } else {
      return [];
    }
  }

  void changeIndexByMeal(int mealId) {
    for (var i = 0; i < meals.length; i++) {
      if (meals[i].id == mealId) {
        selectedindex = i.obs;
      }
    }
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
    if (mealsEnded.value == false) {
      isloading.value = true;
      repo = MealRepo(MealClient());
      if (page > 1) {
        showgetmore = true.obs;
      }
      await repo.getPages(page).then((data) {
        if (data.isNotEmpty) {
          var newmeals = data;

          meals.addAll(newmeals);
          isloading.value = false;
          page++;
          update();
        } else {
          mealsEnded.value = true;
        }
      });
    }
  }

  Future getFeaturedMeals() async {
    repo = MealRepo(MealClient());
    await repo.featuredMeals().then((data) {
      featuredmeals = data;
      //meals.map((Meal e) => e.featured.isEqual(1));
      homeMealsLoaded = true;
      update();
    });
  }

  Future getOffersMeals() async {
    repo = MealRepo(MealClient());
    await repo.offersMeals().then((data) {
      offersmeals = data;
      //meals.map((Meal e) => e.featured.isEqual(1));
      offersMealsLoaded = true;
      update();
    });
  }

  Future getSearch(text) async {
    repo = MealRepo(MealClient());

    await repo.getSearch(text).then((data) {
      searchedMeals = data;
    });
  }
}
