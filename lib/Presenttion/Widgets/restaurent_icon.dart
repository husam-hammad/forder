import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Screens/restaurent_screen.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/custom_styles.dart';

class RestaurentIcon extends StatelessWidget {
  const RestaurentIcon(
      {Key? key, required this.restaurent, required this.smallicon})
      : super(key: key);
  final Restaurent? restaurent;
  final bool smallicon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => RestaurentScreen(restaurent: restaurent!));
      },
      child: Container(
        decoration: !smallicon
            ? BoxDecoration(
                border: Theme.of(context).brightness == Brightness.dark
                    ? Border.all(color: AppColors.green)
                    : null,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.transparent
                    : Theme.of(context).backgroundColor,
                borderRadius: CustomStyles.raduis100)
            : null,
        margin: !smallicon
            ? const EdgeInsets.symmetric(horizontal: 15)
            : const EdgeInsets.all(0),
        width: !smallicon ? 100 : 50,
        height: !smallicon ? 40 : 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: !smallicon ? AppColors.grey : Colors.white,
              radius: smallicon ? 20 : 30,
              child: ClipOval(
                child: FadeInImage(
                  placeholder: const AssetImage(
                      "assets/images/placeholders/restaurent.png"),
                  image: NetworkImage(ImageHelper.buildImage(restaurent!.logo)),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            !smallicon
                ? Text(
                    restaurent!.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox(),
            !smallicon
                ? restaurent!.distance != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            restaurent!.distance < 1
                                ? (restaurent!.distance * 1000)
                                        .toStringAsFixed(0) +
                                    "m"
                                : restaurent!.distance.toString() + "km",
                            style:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(fontSizeFactor: 1.3)
                                    : Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .apply(fontSizeFactor: 1.3),
                          ),
                          const Icon(
                            Icons.delivery_dining,
                            size: 15,
                          ),
                        ],
                      )
                    : const SizedBox()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
