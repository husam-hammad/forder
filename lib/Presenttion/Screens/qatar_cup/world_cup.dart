import 'package:flashorder/BussinessLogic/Controllers/matches_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/appbar.dart';

class WorldCup extends StatelessWidget {
  WorldCup({Key? key}) : super(key: key);
  final MatchesController matchesController = Get.put(MatchesController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
                appBar: buildAppBar(),
                bottomNavigationBar: const CustomBotttomNav(),
                resizeToAvoidBottomInset: true,
                body: Column(
                  children: [
                    pageTitle("المونديال مع فلاش أوردر", null),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/worldcup.png",
                              height: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.matches);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.pink2, width: 1),
                                          borderRadius: CustomStyles.raduis100,
                                          color: AppColors.pink),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.calendar_today,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "مباريات اليوم",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles
                                                .whiteRegularHeading,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.tomorrowmatches);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.green, width: 1),
                                          borderRadius: CustomStyles.raduis100,
                                          color: Theme.of(context)
                                              .backgroundColor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.calendar_month,
                                              color: AppColors.pink2),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "مباريات الغد",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          AppRoutes.worldcuprestaurents);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.green, width: 1),
                                          borderRadius: CustomStyles.raduis100,
                                          color: Theme.of(context)
                                              .backgroundColor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.coffee,
                                            color: AppColors.pink2,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "حجز طاولة للمشاهدة",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
