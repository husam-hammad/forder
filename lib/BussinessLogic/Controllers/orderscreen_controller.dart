import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/helpers/image_helper.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  void showCaptinImage(image) {
    Get.dialog(
        Container(
            padding: const EdgeInsets.all(20),
            child: CachedNetworkImage(
              imageUrl: ImageHelper.buildImage(image),
              fit: BoxFit.contain,
            )),
        transitionCurve: Curves.easeInCubic);
  }
}
