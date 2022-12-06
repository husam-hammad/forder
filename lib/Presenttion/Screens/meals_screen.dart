import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';

import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({Key? key}) : super(key: key);
  final MealsController mealsController = Get.find();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
// nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.9 * scrollController.position.maxScrollExtent;

// _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (scrollController.position.pixels > nextPageTrigger) {
        // ignore: avoid_print
        print(mealsController.isloading.value);
        if (mealsController.isloading.value == false) {
          mealsController.getMeals();
        }
      }
    });
    return SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: buildAppBar(),
          body: Stack(
            children: [
              Positioned(
                bottom: 15,
                left: Get.width / 2,
                child: Obx(() {
                  return mealsController.isloading.value == true
                      ? const CircularProgressIndicator()
                      : Row();
                }),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "mealslist".tr,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height - 210,
                    padding: const EdgeInsets.all(10),
                    child: GetBuilder(
                        init: mealsController,
                        builder: (_) {
                          return ListView.builder(
                              controller: scrollController,
                              itemCount: mealsController.meals.length,
                              itemBuilder: (_, index) {
                                return MealItem(
                                  meal: mealsController.meals[index],
                                );
                              });
                        }),
                  )
                ],
              ),
            ],
          )),
    ));
  }
}
