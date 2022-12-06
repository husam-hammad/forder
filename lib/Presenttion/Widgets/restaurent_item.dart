// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_screen_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Screens/restaurent_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RestaurentItem extends StatelessWidget {
  const RestaurentItem({Key? key, required this.restaurent}) : super(key: key);
  final Restaurent restaurent;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => RestaurentScreen(restaurent: restaurent))!
                .then((value) => Get.delete<RestaurentScreenController>());
          },
          child: Stack(
            children: [
              Hero(
                tag: "restaurent" + restaurent.id.toString(),
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: CustomStyles.raduis50,
                        image: DecorationImage(
                            colorFilter: restaurent.isOpen == 0
                                ? const ColorFilter.mode(
                                    Colors.black, BlendMode.color)
                                : null,
                            filterQuality: FilterQuality.low,
                            image: CachedNetworkImageProvider(
                                ImageHelper.buildImage(restaurent.cover)),
                            onError: (_, __) {
                              print('error');
                            },
                            fit: BoxFit.cover),
                        color: AppColors.lightgrey),
                    height: 150,
                    width: double.infinity,
                  ),
                  Positioned(
                      top: 20,
                      left: 20,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                            ImageHelper.buildImage(restaurent.logo)),
                      )),
                  if (restaurent.isOpen == 0)
                    LottieBuilder.asset(
                      'assets/images/closed.json',
                      width: 100,
                    ),
                  if (restaurent.isOpen == 0)
                    Positioned(
                      left: Get.width / 2 - 60,
                      top: 50,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 1.2)
                            ],
                            borderRadius: CustomStyles.raduis50,
                            color: AppColors.grey),
                        child: Text(
                          "closed".tr,
                          style: AppTextStyles.whiteboldHeading,
                        ),
                      ),
                    )
                ]),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurent.name,
                      style: AppTextStyles.pinkboldHeading,
                    ),
                    Text(
                      restaurent.adrees,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppTextStyles.greyregular.apply(fontSizeFactor: 1.5),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "deliverycost".tr,
                      style: AppTextStyles.greenRegularTitle,
                    ),
                    Text(
                      restaurent.getDeliveryCost().toString() + "sp".tr,
                      style:
                          AppTextStyles.greyregular.apply(fontSizeFactor: 1.5),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
