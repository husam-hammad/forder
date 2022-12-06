import 'package:flashorder/Presenttion/Widgets/shimmer.dart';
import 'package:flutter/material.dart';

class OfferMealShimmer extends StatelessWidget {
  const OfferMealShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: const Shimmerwidget.roundedrectangler(width: 90, height: 90),
    );
  }
}
