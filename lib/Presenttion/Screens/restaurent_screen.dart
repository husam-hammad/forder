import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_screen_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Screens/mealcategory_screen.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurentScreen extends StatelessWidget {
  const RestaurentScreen({Key? key, required this.restaurent})
      : super(key: key);
  final Restaurent restaurent;

  @override
  Widget build(BuildContext context) {
    final RestaurentScreenController controller =
        Get.put(RestaurentScreenController(restaurent));
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: Container(
          padding: const EdgeInsets.all(0),
          color: AppColors.lightwhite,
          width: Get.width,
          height: Get.height,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: ListView(children: [
              Hero(
                tag: "restaurent" + restaurent.id.toString(),
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    ImageHelper.buildImage(restaurent.cover)))),
                      ),
                      Positioned(
                          bottom: 0,
                          left: Get.width / 2 - 55,
                          child: const CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                          )),
                      Positioned(
                          bottom: 5,
                          left: Get.width / 2 - 50,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: CachedNetworkImageProvider(
                                ImageHelper.buildImage(restaurent.logo)),
                          )),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(children: [
                  Text(
                    restaurent.name,
                    style: AppTextStyles.greyboldHeading,
                  ),
                  const Text(
                    "مفتوح",
                    style: AppTextStyles.greyregular,
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "كلفة التوصيل  : ",
                          style: AppTextStyles.greenboldHeading,
                        ),
                        Text(
                          controller.restaurent.getDeliveryCost().toString() +
                              " ل.س ",
                          style: AppTextStyles.greyregular,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: AppColors.green,
                child: const Text(
                  "التصنيفات",
                  style: AppTextStyles.whiteboldHeading,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: GetBuilder(
                    init: controller,
                    builder: (_) {
                      return controller.categoriesLoaded
                          ? ListView.builder(
                              itemCount: controller.mealscategories.length,
                              itemBuilder: (_, index) {
                                // ignore: avoid_print
                                print(controller.mealscategories[index].meals);
                                return InkWell(
                                  onTap: () {
                                    Get.to(MealCategoryScreen(
                                        mealCategory:
                                            controller.mealscategories[index]));
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    color: Colors.white,
                                    child: ListTile(
                                        leading: const Icon(
                                          Icons.fastfood,
                                          color: AppColors.green,
                                        ),
                                        title: Text(controller
                                            .mealscategories[index].name)),
                                  ),
                                );
                              })
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    }),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
