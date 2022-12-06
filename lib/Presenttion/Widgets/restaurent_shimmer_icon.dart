import 'package:flashorder/Presenttion/Widgets/shimmer.dart';

import 'package:flutter/material.dart';

import '../../Constants/colors.dart';
import '../../Constants/custom_styles.dart';

class RestaurentShimmerIcon extends StatelessWidget {
  const RestaurentShimmerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 130,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
          /* border:
                  Border(left: BorderSide(width: 5, color: AppColors.green)), */
          color: AppColors.lightwhite,
          borderRadius: CustomStyles.raduis100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
