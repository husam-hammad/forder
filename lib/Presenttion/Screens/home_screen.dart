// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print

import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/stories_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/story_view.dart';
import 'package:flashorder/Presenttion/Widgets/drawer.dart';
import 'package:flashorder/Presenttion/Widgets/home_meal.dart';
import 'package:flashorder/Presenttion/Widgets/home_widget_shimmer.dart';
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

  RestaurentController restaurentController = Get.put(RestaurentController());
  MealsController mealsController = Get.put(MealsController());
  StoriesController storyController = Get.put(StoriesController());
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightwhite,
        drawer: PublicDrawer(),
        appBar: buildAppBar(),
        body: buildBody(),
        bottomNavigationBar: CustomBotttomNav(),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [buildLatestStories(), buildOthers()],
      ),
    );
  }

  Widget buildLatestStories() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      height: 300,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "أبرز القصص",
                    style: AppTextStyles.greyboldHeading,
                  ),
                  Text(
                    "عرض الكل",
                    style: AppTextStyles.greyregular,
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
                                  Get.to(StoryViewScreen());
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

  Widget buildOthers() {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.maxFinite,
      height: 1000,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 2, offset: Offset.infinite)
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
          color: Colors.white),
      child: Column(
        children: <Widget>[buildRestaurents(), buildHomeMeals()],
      ),
    );
  }

  Widget buildRestaurents() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "المطاعم السورية",
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
                return restaurentController.restaurents.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurentController.restaurents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurentIcon(
                            logo: restaurentController.restaurents[index].logo,
                            name: restaurentController.restaurents[index].name,
                            smallicon: true,
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
              "أبرز الوجبات",
              style: AppTextStyles.greenboldHeading,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: GetBuilder(
              init: mealsController,
              builder: (_) {
                return mealsController.homeMealsLoaded
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mealsController.meals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeMeal(
                            meal: mealsController.meals[index],
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
}
