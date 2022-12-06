import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
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
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: RefreshIndicator(
          onRefresh: () => restaurentController.getResturents(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "restaurents".tr,
                      style: AppTextStyles.pinkboldTopPage,
                    ),
                    Obx(() {
                      return ElevatedButton(
                        onPressed: () {
                          restaurentController.toggleOppened();
                        },
                        style: CustomStyles.acceptButtonStyle,
                        child: Text(
                          restaurentController.oppenedRestaurentToggled.value
                              ? "showrestaurents".tr
                              : "showoppenedrestaurents".tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: Colors.white),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                height: Get.height - 260,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: GetBuilder(
                    init: restaurentController,
                    builder: (_) {
                      return restaurentController.restaurents.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount:
                                  restaurentController.restaurents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RestaurentItem(
                                    restaurent: restaurentController
                                        .restaurents[index]);
                              },
                            );
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
