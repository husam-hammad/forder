// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Screens/Auth/login.dart';
import 'package:flashorder/Presenttion/Screens/Auth/otp.dart';
import 'package:flashorder/Presenttion/Screens/story_view.dart';
import 'package:flashorder/Presenttion/Widgets/drawer.dart';
import 'package:flashorder/Presenttion/Widgets/home_meal.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_icon.dart';
import 'package:flashorder/Presenttion/Widgets/story_item.dart';
/* import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Widgets/story_item.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';

// ignore_for_file: prefer_const_constructors
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightwhite,
        drawer: PublicDrawer(),
        appBar: buildAppBar(),
        body: buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20.0,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: AppColors.green),
          unselectedIconTheme: IconThemeData(color: AppColors.lightgrey),
          selectedLabelStyle: AppTextStyles.greenRegularTitle,
          unselectedLabelStyle: AppTextStyles.greenRegularTitle,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), label: ""),
          ],
        ),
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
      padding: EdgeInsets.all(10),
      height: 280,
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
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.to(StoryViewScreen());
                    },
                    child: StoryItem(
                        image: "",
                        restaurent: Restaurent(
                            id: 1,
                            name: "",
                            imageUrl: "",
                            lat: 0,
                            long: 0,
                            adrees: "")),
                  );
                },
              )),
        ],
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return RestaurentIcon(
                logo: "",
                name: "",
                smallicon: true,
              );
            },
          ),
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return HomeMeal(
                image: "$index.jpg",
                restaurent: Restaurent(
                    id: 1,
                    name: "",
                    lat: 0,
                    long: 0,
                    adrees: "",
                    imageUrl: "$index.jpg"),
              );
            },
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
      backgroundColor: AppColors.pink,
      elevation: 0,
      centerTitle: true,
      title: Column(
        children: [
          Icon(Icons.flash_on),
          Text(
            "The Flash Order",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(Login());
          },
          icon: Icon(Icons.shopping_cart),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {
            Get.to(OtpScreen());
          },
          icon: Icon(Icons.search),
          color: Colors.white,
        )
      ],
    );
  }
}
