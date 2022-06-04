import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/meal_category.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealCategoryScreen extends StatelessWidget {
  const MealCategoryScreen({Key? key, required this.mealCategory})
      : super(key: key);
  final MealCategory mealCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                bottomNavigationBar: CustomBotttomNav(),
                body: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            mealCategory.name,
                            style: AppTextStyles.pinkboldHeading,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height - 210,
                      child: ListView.builder(
                        itemCount: mealCategory.meals!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MealItem(meal: mealCategory.meals![index]);
                        },
                      ),
                    )
                  ],
                ))));
  }
}
