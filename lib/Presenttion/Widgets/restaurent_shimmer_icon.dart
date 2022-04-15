import 'package:flashorder/Presenttion/Widgets/shimmer.dart';

import 'package:flutter/material.dart';

class RestaurentShimmerIcon extends StatelessWidget {
  const RestaurentShimmerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: const [
          Shimmerwidget.circular(width: 60, height: 60),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Shimmerwidget.rectangler(height: 15),
          )
        ],
      ),
    );
  }
}
