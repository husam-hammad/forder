import 'package:flashorder/BussinessLogic/Controllers/order_rating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';
import '../../Constants/custom_styles.dart';
import '../../Constants/textstyles.dart';
import '../Widgets/appbar.dart';

class RatingScreen extends StatelessWidget {
  RatingScreen({Key? key}) : super(key: key);
  final OrderRatingController orderRatingController =
      Get.put(OrderRatingController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              appBar: buildAppBar(),
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: CustomStyles.raduis100,
                      color: AppColors.lightwhite),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "helpusservice".tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.pinkboldHeading,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "amountpaid".tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.greenRegularTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: orderRatingController.paidAmount,
                        textAlign: TextAlign.center,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 172, 172, 172)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.pink,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: AppColors.lightgrey, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "captinrating".tr +
                            ":" +
                            orderRatingController.captinRatingName,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.greenRegularTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: orderRatingController.onCaptinUpate,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "restaurentrating".tr +
                            ":" +
                            orderRatingController.restaurentRatingName,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.greenRegularTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: orderRatingController.onRestaurentUpate,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return ElevatedButton(
                                onPressed: () async {
                                  await orderRatingController.sendRating();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.green,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: orderRatingController
                                              .ratingSendingState.value ==
                                          false
                                      ? Text(
                                          "send".tr,
                                          style: AppTextStyles.whiteboldHeading,
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const CircularProgressIndicator(),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "sending".tr,
                                              style: AppTextStyles
                                                  .whiteboldHeading,
                                            )
                                          ],
                                        ),
                                ),
                              );
                            }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
