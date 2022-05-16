import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/Presenttion/Widgets/restaurent_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurentsScreen extends StatelessWidget {
  RestaurentsScreen({Key? key}) : super(key: key);
  final RestaurentController restaurentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "المطاعم ",
                    style: AppTextStyles.pinkboldTopPage,
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height - 210,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: GetBuilder(
                  init: restaurentController,
                  builder: (_) {
                    return ListView.builder(
                      itemCount: restaurentController.restaurents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RestaurentItem(
                            restaurent:
                                restaurentController.restaurents[index]);
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
