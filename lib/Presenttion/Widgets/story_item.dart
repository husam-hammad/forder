import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/DataAccess/Models/story.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({Key? key, required this.story}) : super(key: key);
  final Story story;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        ImageHelper.buildImage(story.image))),
                borderRadius: CustomStyles.raduis50,
                color: AppColors.lightgrey),
            width: Get.width / 4,
            height: 200),
        Positioned(
            top: 15,
            right: 20,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.lightwhite,
              backgroundImage: CachedNetworkImageProvider(
                  ImageHelper.buildImage(story.restaurent!.logo)),
            ))
      ],
    );
  }
}
