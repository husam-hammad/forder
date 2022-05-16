// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meal_screen_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/favorite.dart';

import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';
import '../Widgets/drawer.dart';

// ignore: must_be_immutable
class MealScreen extends StatelessWidget {
  MealScreen({Key? key}) : super(key: key);
  FavoriteController favoriteController = Get.find();
  late MealScreenController mealController;

  Widget buildBottomButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ElevatedButton(
          style: CustomStyles.acceptButtonStyle,
          onPressed: () {
            mealController.addbuttonEnabled.value == true
                ? mealController.addToCart()
                : null;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Icon(Icons.add), Text("إضافة لسلة الشراء")],
          )),
    );
  }

  Widget buildNumbersText(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "العدد المطلوب ",
            style: AppTextStyles.greenRegularHeading,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      mealController.minusNumber();
                    },
                    child: const Text("-")),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      mealController.addNumber();
                    },
                    child: const Text("+")),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCompomentText(TextEditingController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.add_box_outlined,
                color: AppColors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "طلب مخصص ",
                style: AppTextStyles.greenRegularHeading,
              )
            ],
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: null,
            decoration: const InputDecoration(
                hintText: " أكتب اي مكونات إضافية أو طلب مخصص للشيف",
                contentPadding: EdgeInsets.all(20)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightwhite,
        drawer: PublicDrawer(),
        appBar: buildAppBar(),
        bottomNavigationBar: buildBottomButton(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GetBuilder<MealsController>(
              init: MealsController(),
              builder: (meal) {
                final mealdata =
                    meal.meals[int.parse(meal.selectedindex.toString())];
                mealController = Get.put(MealScreenController(mealdata));
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Hero(
                            tag: "meal:${mealdata.id}",
                            child: Container(
                              height: 300,
                              width: Get.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        mealdata.image),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          GetBuilder(
                              init: mealController,
                              builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        print("meal id : ${mealdata.id}");
                                        mealController.toggle(Favorite(
                                            id: 0, meal_id: mealdata.id));
                                      },
                                      icon: Icon(
                                        mealController.isfav
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                );
                              })
                        ],
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
                                            style: AppTextStyles
                                                .whiteRegularDetail,
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
                            ),
                            buildNumbersText(mealController.numbercontroller),
                            buildCompomentText(
                                mealController.compomentController),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
