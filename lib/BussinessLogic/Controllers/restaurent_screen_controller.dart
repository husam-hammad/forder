// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/DataAccess/Models/meal_category.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/restaurent_repo.dart';
import 'package:get/get.dart';

class RestaurentScreenController extends GetxController {
  final Restaurent restaurent;
  late RestaurentRepo repo;
  RestaurentScreenController(this.restaurent);
  late List<MealCategory> mealscategories = [];
  bool categoriesLoaded = false;

  @override
  void onInit() async {
    super.onInit();
    await getCategories();
    await getRating();
  }

  Future getCategories() async {
    repo = RestaurentRepo(RestaurentClient());
    mealscategories = [];
    await repo.restaurentMealsCategories(restaurent.id).then((data) {
      mealscategories = data;
      categoriesLoaded = true;
    });
    update();
  }

  Future getRating() async {
    repo = RestaurentRepo(RestaurentClient());
    var rate = await repo.getRating(restaurent.id);
    restaurent.rating = int.parse(rate.toString());
    update();
  }
}
