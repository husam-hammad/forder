import 'package:flashorder/BussinessLogic/Controllers/search_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/meal_item.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: searchController.searchText,
                      onChanged: (value) {
                        searchController.doSearch();
                      },
                      decoration: InputDecoration(
                          labelStyle: AppTextStyles.greenRegularTitle,
                          hintText: "البحث في الوجبات والمطاعم",
                          contentPadding: const EdgeInsets.all(5),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.pink)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.pink)),
                          focusColor: AppColors.pink,
                          prefixIconColor: AppColors.green,
                          iconColor: AppColors.pink,
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: AppColors.green,
                              ))),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: Get.height - 210,
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(tabs: [
                              Tab(
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.fastfood,
                                      color: AppColors.green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "الوجبات",
                                      style: AppTextStyles.greenRegularHeading,
                                    )
                                  ],
                                ),
                              ),
                              Tab(
                                  child: Row(
                                children: const [
                                  Icon(
                                    Icons.restaurant,
                                    color: AppColors.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "المطاعم",
                                    style: AppTextStyles.greenRegularHeading,
                                  )
                                ],
                              )),
                            ]),
                            Expanded(
                              child: TabBarView(children: [
                                GetBuilder(
                                  init: searchController,
                                  builder: (_) {
                                    if (searchController
                                        .searchedMeals.isNotEmpty) {
                                      return ListView.builder(
                                          itemCount: searchController
                                              .searchedMeals.length,
                                          itemBuilder: (_, index) {
                                            return MealItem(
                                                meal: searchController
                                                    .searchedMeals[index]);
                                          });
                                    } else {
                                      return const Center(
                                        child: Text("لاتوجد نتائج"),
                                      );
                                    }
                                  },
                                ),
                                GetBuilder(
                                  init: searchController,
                                  builder: (_) {
                                    if (searchController
                                        .searchedRestaurent.isNotEmpty) {
                                      return ListView.builder(
                                          itemCount: searchController
                                              .searchedRestaurent.length,
                                          itemBuilder: (_, index) {
                                            return RestaurentItem(
                                                restaurent: searchController
                                                    .searchedRestaurent[index]);
                                          });
                                    } else {
                                      return const Center(
                                        child: Text("لاتوجد نتائج"),
                                      );
                                    }
                                  },
                                )
                              ]),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          )),
    ));
  }
}
