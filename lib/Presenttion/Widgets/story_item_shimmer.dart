import 'package:flashorder/Presenttion/Widgets/shimmer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryItemShimmer extends StatelessWidget {
  const StoryItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Shimmerwidget.roundedrectangler(width: Get.width / 4, height: 200),
          const Positioned(
              top: 15,
              right: 20,
              child: Shimmerwidget.circular(width: 40, height: 40))
        ],
      ),
    );
  }
}
