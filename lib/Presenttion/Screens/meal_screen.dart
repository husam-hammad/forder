// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';

import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';
import '../Widgets/drawer.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightwhite,
        drawer: const PublicDrawer(),
        appBar: buildAppBar(),
        body: GetBuilder<MealsController>(
            init: MealsController(),
            builder: (meal) {
              final mealdata =
                  meal.meals[int.parse(meal.selectedindex.toString())];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(mealdata.image),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: AppColors.green),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            mealdata.name,
                            style: AppTextStyles.whiteboldHeading,
                          ),
                          Text(
                            mealdata.price.toString() + " ل.س",
                            style: AppTextStyles.whiteboldHeading,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    meal.onInit();
                                  },
                                  icon: const Icon(Icons.refresh)),
                              const Text(
                                "المكونات",
                                style: AppTextStyles.greyboldHeading,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: mealdata.components.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: const BoxDecoration(
                                      borderRadius: CustomStyles.raduis50,
                                      color: AppColors.grey,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          mealdata.components[index],
                                          style:
                                              AppTextStyles.whiteRegularDetail,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              meal.deleteCompoment(
                                                  meal.selectedindex, index);
                                            },
                                            icon: const Icon(Icons.remove))
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
