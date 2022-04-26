// ignore_for_file: avoid_print

import 'package:collection/collection.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_group.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/cart_item_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  late List<CartItem> allcarts;
  RestaurentController restaurentController = Get.find();
  CartItemRepo cartItemRepo = CartItemRepo();
  TextEditingController editQtyController = TextEditingController();
  late Map<Restaurent?, List<CartItem>> groupedList;
  late Map<int, List<CartItem>> groupedListMap;
  late List<CartGroup> cartgroup = [];

  @override
  onInit() async {
    super.onInit();
    await readAll();
  }

  Future<void> readAll() async {
    allcarts = await cartItemRepo.readAll();
    print(allcarts.map((e) => e.restaurentId));
    groupedListMap = groupBy(allcarts, (cart) => cart.restaurentId);

/*     print(allcarts); */
    cartgroup.clear();
    groupedListMap.forEach((key, value) {
      cartgroup.add(CartGroup(restaurentId: key, cartItems: value));
    });
    update();
  }

  Future<void> createItem(CartItem cartItem) async {
    await cartItemRepo.create(cartItem);
    await readAll();
  }

  void editItem(int oldId, int oldqty) {
    editQtyController.value = TextEditingValue(text: oldqty.toString());
    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 200,
            child: Column(
              children: [
                const Text(
                  "قم بإدخال الكمية الجديدة للتعديل",
                  textAlign: TextAlign.right,
                  style: AppTextStyles.greenboldHeading,
                ),
                const Divider(),
                TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: editQtyController,
                  keyboardType: TextInputType.number,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: CustomStyles.acceptButtonStyle,
                      onPressed: () async {
                        int qty = int.parse(editQtyController.value.text);
                        await cartItemRepo.update(oldId, qty);
                        await readAll();
                        Get.back();
                      },
                      child: const Text(
                        "تعديل",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.whiteRegularDetail,
                      )),
                )
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.lightwhite,
        isDismissible: true,
        shape:
            const RoundedRectangleBorder(borderRadius: CustomStyles.raduis100),
        isScrollControlled: true);
  }

  Future<void> deleteItem(int id) async {
    await cartItemRepo.deleteItem(id);
    await readAll();
  }

  Future<void> deleteAll() async {
    /* await cartItemRepo.deleteAll();*/
    await readAll();
  }
}
