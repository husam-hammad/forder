import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/cupertino.dart';

Widget teamFlag(image, name) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CachedNetworkImage(
        imageUrl: ImageHelper.buildImage(image),
        width: 50,
      ),
      Text(
        name,
        style: AppTextStyles.whiteRegularHeading,
      )
    ],
  );
}
