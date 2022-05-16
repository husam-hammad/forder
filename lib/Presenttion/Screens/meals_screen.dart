import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({Key? key}) : super(key: key);
  final MealsController mealsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "الوجبات ",
                    style: AppTextStyles.pinkboldTopPage,
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
      ),
    ));
  }
}
