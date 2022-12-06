import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatelessWidget {
  CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  final CartItem cartItem;
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: cartItem.replacedPoints > 0 ? 80 : 70,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: CustomStyles.raduis50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: CustomStyles.raduis50,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: cartItem.meal != null
                            ? CachedNetworkImageProvider(
                                ImageHelper.buildImage(cartItem.meal!.image))
                            : const CachedNetworkImageProvider(
                                'https://theflashorder.sy/images/meal-placeholder.png'),
                      )),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.meal!.name,
                      style: AppTextStyles.greenRegularHeading,
                    ),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "العدد : ",
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTextStyles.whiteRegularDetail
                                  : AppTextStyles.greyBoldDetail),
                          TextSpan(
                              text: cartItem.qty.toString() + " , ",
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTextStyles.whiteRegularDetail
                                  : AppTextStyles.greyBoldDetail),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "السعر الكامل : ",
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTextStyles.whiteRegularDetail
                                  : AppTextStyles.greyBoldDetail),
                          TextSpan(
                              text: (cartItem.replacedPoints > 0
                                      ? 0
                                      : (cartItem.meal!.offerPrice > 0
                                              ? cartItem.meal!.offerPrice
                                              : cartItem.meal!.price) *
                                          cartItem.qty)
                                  .toString(),
                              style: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTextStyles.whiteRegularDetail
                                  : AppTextStyles.greyBoldDetail),
                        ])),
                      ],
                    ),
                    cartItem.replacedPoints > 0
                        ? RichText(
                            text: TextSpan(children: [
                            const TextSpan(
                                text: "النقاط المستبدلة: ",
                                style: AppTextStyles.greyBoldDetail),
                            TextSpan(
                                text: (cartItem.replacedPoints).toString(),
                                style: AppTextStyles.greyRegularDetail),
                          ]))
                        : Row(),
                  ],
                )),
            Expanded(
                flex: 2,
                child: IconButton(
                    onPressed: () {
                      cartController.editItem(
                          cartItem.id, cartItem.qty, context);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.blueGrey
                          : Colors.blueAccent,
                    ))),
            Expanded(
                flex: 2,
                child: IconButton(
                    onPressed: () {
                      cartController.deleteItem(cartItem);
                    },
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 240, 112, 102)
                          : Colors.redAccent,
                    )))
          ],
        ),
      ),
    );
  }
}
