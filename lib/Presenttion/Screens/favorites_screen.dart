import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  FavoriteController controller = Get.find();
  MealsController mealsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: CustomBotttomNav(),
        body: Container(
          width: Get.width,
          color: AppColors.lightwhite,
          child: controller.favorites.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "الوجبات المفضلة",
                            style: AppTextStyles.pinkboldTopPage,
                          ),
                          InkWell(
                            onTap: () {
                              controller.deleteAll();
                            },
                            child: const Text(
                              "حذف الكل",
                              style: AppTextStyles.greyregular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height - 210,
                      child: GetBuilder(
                        init: controller,
                        builder: (_) {
                          return ListView.builder(
                              itemCount: controller.favorites.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                Meal? getmeal = mealsController.mealFromId(
                                    controller.favorites[index].meal_id);
                                return getmeal != null
                                    ? MealItem(meal: getmeal)
                                    : Container();
                              });
                        },
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text("لا توجد وجبات مفضلة"),
                ),
        ),
      ),
    ));
  }
}
