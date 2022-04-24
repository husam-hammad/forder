import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Screens/restaurent_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/textstyles.dart';

class RestaurentIcon extends StatelessWidget {
  const RestaurentIcon(
      {Key? key, required this.restaurent, required this.smallicon})
      : super(key: key);
  final Restaurent? restaurent;
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
            radius: smallicon ? 15 : 30,
            child: ClipOval(
              child: InkWell(
                onTap: () {
                  Get.to(RestaurentScreen(restaurent: restaurent!));
                },
                child: FadeInImage(
                  placeholder: const AssetImage(
                      "assets/images/placeholders/restaurent.png"),
                  image: NetworkImage(ImageHelper.buildImage(restaurent!.logo)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          !smallicon
              ? Text(
                  restaurent!.name,
                  style: AppTextStyles.greyregular,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
