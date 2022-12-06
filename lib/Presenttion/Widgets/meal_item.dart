// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meal_screen_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Screens/meal_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';
import '../../Constants/textstyles.dart';

class MealItem extends StatelessWidget {
  MealItem({Key? key, required this.meal}) : super(key: key);
  final Meal meal;
  final CartController cartcontrolelr = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 112,
        decoration: BoxDecoration(
            border: Theme.of(context).brightness == Brightness.dark
                ? Border.all(color: AppColors.green)
                : null,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : Theme.of(context).backgroundColor,
            borderRadius: CustomStyles.raduis50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: GetBuilder<MealsController>(builder: (controller) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => MealScreen(), arguments: [meal])!.then(
                              (value) => Get.delete<MealScreenController>());
                        },
                        child: Hero(
                          tag: "meal:${meal.id}",
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: CustomStyles.raduis50,
                                image: DecorationImage(
                                    colorFilter: meal.isOpen == 0
                                        ? const ColorFilter.mode(
                                            Colors.black, BlendMode.color)
                                        : null,
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        ImageHelper.buildImage(meal.image)))),
                          ),
                        ),
                      ),
                      if (meal.isOpen == 0)
                        Positioned(
                          left: 15,
                          top: 50,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 1.2)
                                ],
                                borderRadius: CustomStyles.raduis50,
                                color: AppColors.grey),
                            child: Text(
                              "closed".tr,
                              style: AppTextStyles.whiteboldHeading
                                  .apply(fontSizeFactor: .8),
                            ),
                          ),
                        ),
                    ],
                  );
                })),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    meal.restaurent != null
                        ? Text(
                            meal.restaurent!.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : Row(),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "price".tr + " : ",
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: meal.price.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "deliverycost".tr + " : ",
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: meal.restaurent?.getDeliveryCost() != 0
                              ? meal.restaurent?.getDeliveryCost().toString()
                              : "",
                          style: Theme.of(context).textTheme.bodySmall)
                    ]))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
