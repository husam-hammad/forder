// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Screens/meal_screen.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart';
import 'package:flashorder/helpers/image_helper.dart';
/* import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BussinessLogic/Controllers/meal_screen_controller.dart';
import '../../Constants/textstyles.dart';

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
                Get.to(() => MealScreen(), arguments: [meal])!
                    .then((value) => Get.delete<MealScreenController>());
              },
              child: Hero(
                tag: "meal:${meal.id}",
                child: Container(
                  decoration: BoxDecoration(
                      border: Theme.of(context).brightness == Brightness.dark
                          ? Border.all(color: AppColors.green)
                          : null,
                      borderRadius: CustomStyles.raduis50,
                      image: DecorationImage(
                          colorFilter: meal.isOpen == 0
                              ? const ColorFilter.mode(
                                  Colors.black, BlendMode.color)
                              : null,
                          filterQuality: FilterQuality.low,
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
              right: 10,
              child: RestaurentIcon(
                restaurent: meal.restaurent,
                smallicon: true,
              ),
            ),
            if (meal.isOpen == 0)
              Positioned(
                left: 90,
                top: 50,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 1.2)
                      ],
                      borderRadius: CustomStyles.raduis50,
                      color: AppColors.grey),
                  child: Text(
                    "closed".tr,
                    style: AppTextStyles.whiteboldHeading,
                  ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            meal.name,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(meal.price.toString(),
                              style: Theme.of(context).textTheme.titleLarge),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }
}
