import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/loading_item.dart';
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
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: Container(
          width: Get.width,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: controller.favorites.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "favorites".tr,
                            style: AppTextStyles.pinkboldTopPage,
                          ),
                          InkWell(
                            onTap: () {
                              controller.deleteAll();
                            },
                            child: Text(
                              "deleteall".tr,
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTextStyles.whiteRegularDetail
                                  : AppTextStyles.greyBoldDetail,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height - 215,
                      child: GetBuilder(
                        init: controller,
                        builder: (_) {
                          return controller.isloading
                              ? loadingItemGreen()
                              : ListView.builder(
                                  itemCount: controller.favorites.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Meal? getmeal = controller.mealbyId(
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
              : Center(
                  child: Text("noresults".tr),
                ),
        ),
      ),
    ));
  }
}
