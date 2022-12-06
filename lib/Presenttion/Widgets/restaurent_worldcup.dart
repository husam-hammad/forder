// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';

class RestaurentItemWC extends StatelessWidget {
  const RestaurentItemWC({Key? key, required this.restaurent})
      : super(key: key);
  final Restaurent restaurent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: CustomStyles.raduis50,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            ImageHelper.buildImage(restaurent.cover)),
                        onError: (_, __) {
                          print('error');
                        },
                        fit: BoxFit.cover),
                    color: AppColors.lightgrey),
                height: 100,
                width: double.infinity,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurent.name,
                  style: AppTextStyles.greenBoldTitle,
                ),
                Text(
                  restaurent.adrees,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).brightness == Brightness.dark
                      ? AppTextStyles.greyregular
                          .apply(fontSizeFactor: 1.5, color: Colors.white)
                      : AppTextStyles.greyregular.apply(fontSizeFactor: 1.5),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
