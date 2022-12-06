// ignore_for_file: avoid_print, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/Ads/ads_restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_screen_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/mealcategory_screen.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/loading_item.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsRestaurentScreen extends StatelessWidget {
  AdsRestaurentScreen({Key? key}) : super(key: key);

  final AdsRestaurentController adscontroller = Get.put(
      AdsRestaurentController(int.parse(Get.parameters['id']!.toString())));
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: adscontroller,
        builder: (_) {
          print(adscontroller.restaurent);
          if (adscontroller.restaurent == null) {
            return SafeArea(
              child: Directionality(
                textDirection: Get.locale!.languageCode == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Scaffold(
                  appBar: buildAppBar(),
                  body: Center(child: loadingItemGreen()),
                ),
              ),
            );
          } else {
            final RestaurentScreenController controller =
                Get.put(RestaurentScreenController(adscontroller.restaurent!));
            return SafeArea(
                child: Directionality(
              textDirection: Get.locale!.languageCode == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: Scaffold(
                appBar: buildAppBar(),
                bottomNavigationBar: const CustomBotttomNav(),
                body: Container(
                  padding: const EdgeInsets.all(0),
                  width: Get.width,
                  height: Get.height,
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: ListView(children: [
                      Hero(
                        tag: "restaurent" +
                            adscontroller.restaurent!.id.toString(),
                        child: SizedBox(
                          height: 260,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            ImageHelper.buildImage(adscontroller
                                                .restaurent!.cover)))),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "orderability".tr,
                                        style: AppTextStyles.greyBoldDetail,
                                      ),
                                      Text(
                                        adscontroller.restaurent!.isOpen
                                                    .toString() ==
                                                "1"
                                            ? "opened".tr
                                            : "closed".tr,
                                        style: adscontroller.restaurent!.isOpen
                                                    .toString() ==
                                                "1"
                                            ? AppTextStyles.greenRegularHeading
                                            : AppTextStyles.redRegularHeading,
                                      ),
                                    ],
                                  )),
                              Positioned(
                                bottom: 0,
                                left: 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "deliverycost".tr,
                                      style: AppTextStyles.greyBoldDetail,
                                    ),
                                    Text(
                                        controller.restaurent
                                                .getDeliveryCost()
                                                .toString() +
                                            "sp".tr,
                                        style:
                                            AppTextStyles.greenRegularHeading)
                                  ],
                                ),
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
                                        ImageHelper.buildImage(
                                            adscontroller.restaurent!.logo)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                adscontroller.restaurent!.name,
                                style: AppTextStyles.pinkboldHeading,
                              ),
                              Text(adscontroller.restaurent!.adrees,
                                  style: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTextStyles.whiteRegularDetail
                                          .apply(fontSizeFactor: 1.5)
                                      : AppTextStyles.greyregular
                                          .apply(fontSizeFactor: 1.5)),
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GetBuilder(
                        init: controller,
                        builder: (_) {
                          return SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Center(
                              child: controller.restaurent.rating != 0
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.restaurent.rating,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        );
                                      },
                                    )
                                  : Row(),
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: AppColors.green,
                        child: Text(
                          "categories".tr,
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
                                      itemCount:
                                          controller.mealscategories.length,
                                      itemBuilder: (_, index) {
                                        // ignore: avoid_print
                                        print(controller
                                            .mealscategories[index].meals);
                                        return InkWell(
                                          onTap: () {
                                            Get.to(MealCategoryScreen(
                                                mealCategory: controller
                                                    .mealscategories[index]));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            child: ListTile(
                                                leading: const Icon(
                                                  Icons.fastfood,
                                                  color: AppColors.green,
                                                ),
                                                title: Text(controller
                                                    .mealscategories[index]
                                                    .name)),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: loadingItemGreen(),
                                    );
                            }),
                      ),
                    ]),
                  ),
                ),
              ),
            ));
          }
        });
  }
}
