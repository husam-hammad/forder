import 'package:flashorder/BussinessLogic/Controllers/matches_controller.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/match_item.dart';
import 'package:flashorder/Presenttion/Widgets/page_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/appbar.dart';

class TomorrowMatches extends StatelessWidget {
  TomorrowMatches({Key? key}) : super(key: key);
  final MatchesController matchesController = Get.find();
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
                body: Column(
                  children: [
                    pageTitle("مباريات الغد", null),
                    GetBuilder(
                        init: matchesController,
                        builder: (_) {
                          return matchesController.isloading.value == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  height: Get.height - 260,
                                  child: RefreshIndicator(
                                    onRefresh: () async =>
                                        await matchesController.load(),
                                    child: ListView.builder(
                                      itemCount: matchesController
                                          .tomorrowMatches.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MatchItem(
                                            match: matchesController
                                                .tomorrowMatches[index]);
                                      },
                                    ),
                                  ),
                                );
                        })
                  ],
                ))));
  }
}
