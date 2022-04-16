import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/Presenttion/Screens/meal_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealItem extends StatelessWidget {
  const MealItem({Key? key, required this.meal}) : super(key: key);
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Hero(
                  tag: "meal:${meal.id}",
                  child: InkWell(
                    onTap: () {
                      Get.to(MealScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: CustomStyles.raduis50,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  ImageHelper.buildImage(meal.image)))),
                    ),
                  ),
                )),
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
                      style: AppTextStyles.greenRegularHeading,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "السعر : ", style: AppTextStyles.greyregular),
                      TextSpan(
                          text: meal.price.toString(),
                          style: AppTextStyles.greyregular),
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "كلفة التوصيل : ",
                          style: AppTextStyles.greyregular),
                      TextSpan(
                          text: meal.price.toString(),
                          style: AppTextStyles.greyregular),
                    ]))
                  ],
                )),
            Expanded(
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}
