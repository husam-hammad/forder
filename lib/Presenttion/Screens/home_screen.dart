// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print

import 'dart:ui';

import 'package:flashorder/BussinessLogic/Controllers/connectivity_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/stories_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
/* import 'package:flashorder/Constants/routes.dart'; */
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/story_view.dart';
import 'package:flashorder/Presenttion/Widgets/drawer.dart';
import 'package:flashorder/Presenttion/Widgets/home_meal.dart';
import 'package:flashorder/Presenttion/Widgets/home_widget_shimmer.dart';
import 'package:flashorder/Presenttion/Widgets/noconnection.dart';
import 'package:flashorder/Presenttion/Widgets/offer_meal.dart';
import 'package:flashorder/Presenttion/Widgets/offer_meal_shimmer.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_shimmer_icon.dart';
//import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart';
import 'package:flashorder/Presenttion/Widgets/story_item.dart';
import 'package:flashorder/Presenttion/Widgets/story_item_shimmer.dart';
//import 'package:flutter/foundation.dart';
/* import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Widgets/story_item.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/appbar.dart';
import '../Widgets/custom_bottom.dart';
import '../Widgets/restaurent_icon.dart';
//import 'package:get/get.dart';

// ignore_for_file: prefer_const_constructors
// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final SettingsController settingsController = Get.find();
  final HomeController homeController = Get.find();
  final RestaurentController restaurentController = Get.find();
  final MealsController mealsController = Get.find();
  final StoriesController storyController = Get.find();
  final FavoriteController favoriteController = Get.find();
  final UserController userController = Get.find();
  final ConnectivityController connectivityController = Get.find();

  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    PlatformDispatcher.instance.onLocaleChanged = () {
      print("start rebuid");
      (context as Element).visitChildren(rebuild);
    };
    return GetBuilder(
        init: connectivityController,
        builder: (_) {
          return Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: connectivityController.connected == false
                ? NoConnection()
                : Scaffold(
                    backgroundColor: /* AppColors.lightwhite */ Theme
                            .of(context)
                        .backgroundColor,
                    drawer: PublicDrawer(
                      userController: userController,
                    ),
                    appBar: buildAppBar(),
                    body: buildBody(context),
                    bottomNavigationBar: CustomBotttomNav(),
                  ),
          );
        });
  }

  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await homeController.rebuild();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            /* homeController.buildHello(), */
            /* ElevatedButton(
                onPressed: () => {Get.toNamed(AppRoutes.ratingscreen)},
                child: Text("test")), */
            buildLatestStories(context),
            buildOthers(context)
          ],
        ),
      ),
    );
  }

  Widget buildLatestStories(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      height: 300,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "lateststories".tr,
                    style: AppTextStyles.greenboldHeading,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.symmetric(vertical: 15),
              height: 200,
              child: GetBuilder(
                  init: storyController,
                  builder: (_) {
                    return storyController.stories.isNotEmpty
                        ? ListView.builder(
                            itemCount: storyController.stories.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(StoryViewScreen(goto: index));
                                },
                                child: StoryItem(
                                  story: storyController.stories[index],
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return StoryItemShimmer();
                            },
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOthers(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.maxFinite,
      height: 700,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 2, offset: Offset.infinite)
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: <Widget>[
          buildRestaurents(),
          SizedBox(
            height: 20,
          ),
          buildOfferMeals(),
          SizedBox(
            height: 20,
          ),
          buildHomeMeals(),
        ],
      ),
    );
  }

  Widget buildRestaurents() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.restaurant,
              size: 20,
              color: AppColors.green2,
            ),
            Text(
              "restaurentsnearby".tr,
              style: AppTextStyles.greenboldHeading,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          height: 120,
          child: GetBuilder(
              init: restaurentController,
              builder: (_) {
                return restaurentController.nearestrestaurents.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            restaurentController.nearestrestaurents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurentIcon(
                            restaurent:
                                restaurentController.nearestrestaurents[index],
                            smallicon: false,
                          );
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurentShimmerIcon();
                        },
                      );
              }),
        )
      ],
    );
  }

  Widget buildHomeMeals() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.star_rate,
              color: AppColors.green,
            ),
            Text(
              "featuredmeals".tr,
              style: AppTextStyles.greenboldHeading,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 180,
          width: double.infinity,
          child: GetBuilder(
              init: mealsController,
              builder: (_) {
                return mealsController.homeMealsLoaded
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mealsController.featuredmeals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeMeal(
                            meal: mealsController.featuredmeals[index],
                            index: index,
                          );
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeMealShimmer();
                        },
                      );
              }),
        ),
      ],
    );
  }

  Widget buildOfferMeals() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.local_fire_department,
              color: Colors.orangeAccent,
            ),
            Text(
              "offersmeals".tr,
              style: AppTextStyles.greenboldHeading,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 160,
          width: double.infinity,
          child: GetBuilder(
              init: mealsController,
              builder: (_) {
                return mealsController.offersMealsLoaded
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mealsController.offersmeals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OfferMeal(
                            meal: mealsController.offersmeals[index],
                          );
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return OfferMealShimmer();
                        },
                      );
              }),
        ),
      ],
    );
  }
}
