// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Screens/restaurent_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Get.to(RestaurentScreen(restaurent: restaurent));
          },
          child: Hero(
            tag: "restaurent" + restaurent.id.toString(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: CustomStyles.raduis50,
                  image: DecorationImage(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurent.name,
                style: AppTextStyles.pinkboldHeading,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "كلفة التوصيل",
                    style: AppTextStyles.greenRegularTitle,
                  ),
                  Text(
                    restaurent.getDeliveryCost().toString() + "ل.س",
                    style: AppTextStyles.greyregular,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
