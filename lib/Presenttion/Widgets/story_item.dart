import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({Key? key, required this.image, required this.restaurent})
      : super(key: key);
  final String image;
  final Restaurent restaurent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            decoration: const BoxDecoration(
                borderRadius: CustomStyles.raduis50,
                color: AppColors.lightgrey),
            width: Get.width / 4,
            height: 200),
        const Positioned(
            top: 15,
            right: 20,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.lightwhite,
            ))
      ],
    );
  }
}
