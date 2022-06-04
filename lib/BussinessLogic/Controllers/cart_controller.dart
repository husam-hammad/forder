// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flashorder/BussinessLogic/Controllers/appbar_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/order_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/cart_group.dart';
import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/order_info.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/DataAccess/Repository/cart_item_repo.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  late List<CartItem> allcarts;
  RestaurentController restaurentController = Get.find();
  AppBarController appBarController = Get.find();
  CartItemRepo cartItemRepo = CartItemRepo();
  TextEditingController editQtyController = TextEditingController();
  PlacesController placesController = Get.find();
  OrderController orderController = Get.find();
  late Map<Restaurent?, List<CartItem>> groupedList;
  late Map<int, List<CartItem>> groupedListMap;
  late User? user;
  late List<CartGroup> cartgroup = [];
  var box = GetStorage();

  var isSending = false.obs;

  late double orderlat = MyApp.userPosition!.latitude;
  late double orderlong = MyApp.userPosition!.longitude;
  @override
  onInit() async {
    super.onInit();
    await readAll();
  }

  Future<void> readAll() async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
    }

    allcarts = await cartItemRepo.readAll();
    groupedListMap = groupBy(allcarts, (cart) => cart.restaurentId);

/*     print(allcarts); */
    cartgroup.clear();
    groupedListMap.forEach((key, value) {
      cartgroup
          .add(CartGroup(restaurentId: key, cartItems: value, orderInfo: null));
    });
    //print(jsonEncode(cartgroup));

    update();
    appBarController.cartempty = allcarts.isEmpty;
    appBarController.update();
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
    await cartItemRepo.deleteAll();
    await readAll();
  }

  Future<void> setPosition() async {
    await Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 350,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              ListTile(
                title: const Text(
                  "ارسال للموقع الحالي",
                  textAlign: TextAlign.right,
                ),
                onTap: () {
                  orderlat = MyApp.userPosition!.latitude;
                  orderlong = MyApp.userPosition!.longitude;
                  Get.back();
                  update();
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                  itemCount: placesController.places.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        placesController.places[index].name,
                        textAlign: TextAlign.right,
                      ),
                      onTap: () {
                        orderlat = placesController.places[index].lat;
                        orderlong = placesController.places[index].long;
                        Get.back();
                        update();
                      },
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
        shape:
            const RoundedRectangleBorder(borderRadius: CustomStyles.raduis100),
        elevation: 2.5,
        backgroundColor: Colors.white,
        isDismissible: true,
        isScrollControlled: true);
  }

  void sendorder() async {
    isSending.value = true;
    await setPosition();
    for (var item in cartgroup) {
      num singleOrdeValue = 0;

      for (var cart in item.cartItems) {
        cart.price = cart.meal!.price;
        cart.allPrice = cart.price * cart.qty;
        singleOrdeValue += cart.allPrice;
      }
      Restaurent? temprest =
          restaurentController.restaunretFromId(item.restaurentId!);
      print("user id is >>>>> " + user!.id.toString());
      item.orderInfo = OrderInfo(
          userId: user!.id,
          restaurentId: item.restaurentId!,
          pLat: orderlat,
          pLong: orderlong,
          orderValue: singleOrdeValue,
          deliveryCost: temprest!.getDeliveryCost());
    }

    OrderClient client = OrderClient();
    bool isSent = await client.sendOrder(jsonEncode(cartgroup));
    if (isSent) {
      await deleteAll();
      await orderController.getAll();
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: const Text(
          "تم إرسال الطلب بنجاح",
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: AppColors.green,
      );
    } else {
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: const Text(
          "خطأ أثناء الإرسال",
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: Colors.redAccent,
      );
    }
    isSending.value = false;
    /* for (var item in allcarts) {
      item.price = item.meal!.price;
      item.allPrice = item.price * item.qty;
    }
    //update();
    print(jsonEncode(allcarts)); */
  }
}
