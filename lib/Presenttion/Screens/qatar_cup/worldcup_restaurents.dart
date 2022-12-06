import 'package:flashorder/BussinessLogic/Controllers/matches_controller.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/page_title.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_worldcup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/appbar.dart';

class WorldCupRestaunrets extends StatelessWidget {
  WorldCupRestaunrets({Key? key}) : super(key: key);
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
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: [
                    pageTitle("حجز طاولة", null),
                    GetBuilder(
                        init: matchesController,
                        builder: (_) {
                          return matchesController.isloading.value == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RefreshIndicator(
                                  onRefresh: () async {
                                    await matchesController.load();
                                  },
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: Get.height - 260,
                                        child: ListView.builder(
                                          itemCount: matchesController
                                              .restaurents.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () async {
                                                matchesController
                                                    .showTableDialog(
                                                        matchesController
                                                            .restaurents[
                                                                index]
                                                            .name,
                                                        matchesController
                                                            .restaurents[
                                                                index]
                                                            .id);
                                              },
                                              child: RestaurentItemWC(
                                                  restaurent:
                                                      matchesController
                                                              .restaurents[
                                                          index]),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        })
                  ],
                ))));
  }
}
