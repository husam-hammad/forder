import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../BussinessLogic/Controllers/meal_screen_controller.dart';
import '../../helpers/image_helper.dart';
import '../Screens/meal_screen.dart';

class OfferMeal extends StatelessWidget {
  const OfferMeal({Key? key, required this.meal}) : super(key: key);
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MealScreen(), arguments: [meal])!
            .then((value) => Get.delete<MealScreenController>());
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: CustomStyles.raduis100,
                border: Theme.of(context).brightness == Brightness.dark
                    ? Border.all(color: Colors.orangeAccent)
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: CustomStyles.raduis50,
                        image: DecorationImage(
                            colorFilter: meal.isOpen == 0
                                ? const ColorFilter.mode(
                                    Colors.black, BlendMode.color)
                                : null,
                            filterQuality: FilterQuality.low,
                            image: CachedNetworkImageProvider(
                                ImageHelper.buildImage(meal.image)),
                            onError: (_, __) {},
                            fit: BoxFit.cover))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              meal.name,
              style: Theme.of(context).textTheme.bodySmall,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
