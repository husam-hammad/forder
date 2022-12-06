import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/box.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/appbar.dart';
import '../Widgets/loading_item.dart';

class BoxScreen extends StatelessWidget {
  BoxScreen({Key? key, required this.box}) : super(key: key);
  final CartController cartController = Get.find();
  final Box box;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
            textDirection: Get.locale!.languageCode == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
                appBar: buildAppBar(),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: CustomStyles.acceptButtonStyle,
                      onPressed: () {
                        if (cartController.isSending.value == false) {
                          cartController.sendBox(box.id);
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (cartController.isSending.value) loadingItem(),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "applybox".tr,
                            style: AppTextStyles.whiteRegularHeading,
                          )
                        ],
                      )),
                ),
                body: Container(
                  width: Get.width,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          backgroundColor: AppColors.green,
                          automaticallyImplyLeading: false,
                          expandedHeight: Get.width,
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                                borderRadius: CustomStyles.raduis100Bottom,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        ImageHelper.buildImage(box.image)))),
                          )),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: Get.width,
                                decoration: const BoxDecoration(
                                    borderRadius: CustomStyles.raduis100Bottom,
                                    color: AppColors.green),
                                child: Text(
                                  box.title,
                                  style: AppTextStyles.whiteboldHeading,
                                  textAlign: TextAlign.center,
                                )),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "إجمالي العرض : " +
                                          box.orderValue.toString(),
                                      style: AppTextStyles.greenBoldTitle
                                          .apply(fontSizeDelta: 2),
                                    ),
                                    if (box.discount > 0)
                                      Text(
                                        "الحسم : " + box.discount.toString(),
                                        style:
                                            AppTextStyles.greenBoldTitle.apply(
                                          fontSizeDelta: 2,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    if (box.discount > 0)
                                      Text(
                                        "صافي العرض : " +
                                            box.finalValue.toString(),
                                        style: AppTextStyles.greenBoldTitle
                                            .apply(fontSizeDelta: 2),
                                      ),
                                  ],
                                ))),
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        "boxcontent".tr,
                                        style: AppTextStyles.pinkRegularHeading,
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: Get.width,
                                height: 500,
                                child: ListView.builder(
                                    itemCount: box.details!.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        title: Text(
                                          box.details![index].meal.name,
                                          style: AppTextStyles.pinkboldHeading,
                                        ),
                                        isThreeLine: true,
                                        subtitle: RichText(
                                          text: TextSpan(children: [
                                            const TextSpan(
                                                text: "العدد : ",
                                                style: AppTextStyles
                                                    .greyBoldDetail),
                                            TextSpan(
                                                text: box.details![index].qty
                                                        .toString() +
                                                    " - ",
                                                style: AppTextStyles
                                                    .greyRegularDetail),
                                            const TextSpan(
                                                text: "الافرادي : ",
                                                style: AppTextStyles
                                                    .greyBoldDetail),
                                            TextSpan(
                                                text: box.details![index].price
                                                        .toString() +
                                                    " - ",
                                                style: AppTextStyles
                                                    .greyRegularDetail),
                                            const TextSpan(
                                                text: "الاجمالي : ",
                                                style: AppTextStyles
                                                    .greyBoldDetail),
                                            TextSpan(
                                                text: box
                                                    .details![index].allPrice
                                                    .toString(),
                                                style: AppTextStyles
                                                    .greyRegularDetail),
                                          ]),
                                        ),
                                        leading: CircleAvatar(
                                            radius: 50,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    ImageHelper.buildImage(box
                                                        .details![index]
                                                        .meal
                                                        .image))),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
