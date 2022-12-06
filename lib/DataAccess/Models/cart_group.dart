import 'dart:convert';

import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/order_info.dart';

class CartGroup {
  int? restaurentId;
  List<CartItem> cartItems;
  OrderInfo? orderInfo;
  num finalval = 0;
  num categoryDiscount = 0;
  num restaunretDiscount = 0;
  CartGroup({
    this.restaurentId,
    required this.cartItems,
    required this.orderInfo,
    required this.finalval,
    required this.categoryDiscount,
    required this.restaunretDiscount,
  });

  CartGroup copyWith({
    int? restaurentId,
    List<CartItem>? cartItems,
    OrderInfo? orderInfo,
  }) {
    return CartGroup(
        restaurentId: restaurentId ?? this.restaurentId,
        cartItems: cartItems ?? this.cartItems,
        orderInfo: orderInfo ?? this.orderInfo,
        finalval: finalval,
        categoryDiscount: categoryDiscount,
        restaunretDiscount: restaunretDiscount);
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurentId': restaurentId,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'orderInfo': orderInfo?.toMap(),
      'finalval': finalval,
      'categoryDiscount': categoryDiscount,
      'restaunretDiscount': restaunretDiscount,
    };
  }

  factory CartGroup.fromMap(Map<String, dynamic> map) {
    return CartGroup(
      restaurentId: map['restaurentId']?.toInt(),
      cartItems: List<CartItem>.from(
          map['cartItems']?.map((x) => CartItem.fromMap(x))),
      orderInfo:
          map['orderInfo'] != null ? OrderInfo.fromMap(map['orderInfo']) : null,
      finalval: map['finalval'] ?? 0,
      categoryDiscount: map['categoryDiscount'] ?? 0,
      restaunretDiscount: map['restaunretDiscount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartGroup.fromJson(String source) =>
      CartGroup.fromMap(json.decode(source));
}
