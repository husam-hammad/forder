import 'package:flashorder/BussinessLogic/Controllers/compliments_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplimentScreen extends StatelessWidget {
  ComplimentScreen({Key? key}) : super(key: key);
  final complimentController =
      Get.put<ComplimentController>(ComplimentController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            complimentController.showAdd();
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "الشكاوى والاٌقتراحات ",
                    style: AppTextStyles.pinkboldHeading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
