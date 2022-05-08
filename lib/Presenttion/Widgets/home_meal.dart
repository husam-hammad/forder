// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Screens/meal_screen.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart';
import 'package:flashorder/helpers/image_helper.dart';
/* import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMeal extends StatelessWidget {
  const HomeMeal({Key? key, required this.meal, required this.index})
      : super(key: key);
  final Meal meal;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MealsController>(builder: (mealindex) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                mealindex.changeIndexByMeal(meal.id);
                Get.to(MealScreen());
              },
              child: Hero(
                tag: "meal:${meal.id}",
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: CustomStyles.raduis50,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              ImageHelper.buildImage(meal.image)),
                          onError: (_, __) {
                            print('error');
                          },
                          fit: BoxFit.cover),
                      color: AppColors.lightgrey),
                  height: 150,
                  width: 250,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: RestaurentIcon(
                restaurent: meal.restaurent,
                smallicon: true,
              ),
            ),
            Positioned(
                top: 90,
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: const BoxDecoration(
                      borderRadius: CustomStyles.raduis50,
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(0, 0, 0, 0),
                            Color.fromARGB(118, 0, 0, 0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        meal.name,
                        style: AppTextStyles.whiteboldHeading,
                      ),
                      Text(meal.price.toString(),
                          style: AppTextStyles.whiteboldHeading)
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
