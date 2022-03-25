import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';

import '../../Constants/textstyles.dart';

class RestaurentIcon extends StatelessWidget {
  const RestaurentIcon(
      {Key? key,
      required this.logo,
      required this.name,
      required this.smallicon})
      : super(key: key);
  final String logo;
  final String name;
  final bool smallicon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AppColors.grey,
            radius: smallicon ? 30 : 10,
            child: ClipOval(
              child: FadeInImage(
                placeholder: const AssetImage(
                    "assets/images/placeholders/restaurent.png"),
                image: NetworkImage(ImageHelper.buildImage(logo)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          smallicon == true
              ? Text(
                  name,
                  style: AppTextStyles.greyregular,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
