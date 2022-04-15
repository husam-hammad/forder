import 'package:flashorder/Presenttion/Widgets/shimmer.dart';
import 'package:flutter/material.dart';

class HomeMealShimmer extends StatelessWidget {
  const HomeMealShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: const [
          Shimmerwidget.roundedrectangler(width: 250, height: 150),
          Positioned(
              top: 10,
              right: 40,
              child: Shimmerwidget.circular(width: 15, height: 15)),
        ],
      ),
    );
  }
}
