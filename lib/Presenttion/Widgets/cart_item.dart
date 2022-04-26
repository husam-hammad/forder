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
        height: 70,
        color: Colors.white,
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
                          image: CachedNetworkImageProvider(
                              ImageHelper.buildImage(cartItem.meal!.image)))),
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
                      cartItem.meal!.name +
                          "   " +
                          cartItem.restaurentId.toString(),
                      style: AppTextStyles.greenRegularHeading,
                    ),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "العدد : ",
                              style: AppTextStyles.greyBoldDetail),
                          TextSpan(
                              text: cartItem.qty.toString() + " , ",
                              style: AppTextStyles.greyRegularDetail),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "السعر الكامل : ",
                              style: AppTextStyles.greyBoldDetail),
                          TextSpan(
                              text: (cartItem.meal!.price * cartItem.qty)
                                  .toString(),
                              style: AppTextStyles.greyRegularDetail),
                        ]))
                      ],
                    )
                  ],
                )),
            Expanded(
                flex: 2,
                child: IconButton(
                    onPressed: () {
                      cartController.editItem(cartItem.id, cartItem.qty);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ))),
            Expanded(
                flex: 2,
                child: IconButton(
                    onPressed: () {
                      cartController.deleteItem(cartItem.id);
                    },
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.redAccent,
                    )))
          ],
        ),
      ),
    );
  }
}
