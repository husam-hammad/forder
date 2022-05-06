import 'dart:convert';

import 'package:flashorder/DataAccess/Models/cart_item.dart';
import 'package:flashorder/DataAccess/Models/order_info.dart';

class CartGroup {
  int? restaurentId;
  List<CartItem> cartItems;
  OrderInfo? orderInfo;
  CartGroup({
    this.restaurentId,
    required this.cartItems,
    required this.orderInfo,
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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurentId': restaurentId,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'orderInfo': orderInfo!.toMap(),
    };
  }

  factory CartGroup.fromMap(Map<String, dynamic> map) {
    return CartGroup(
      restaurentId: map['restaurentId']?.toInt(),
      cartItems: List<CartItem>.from(
          map['cartItems']?.map((x) => CartItem.fromMap(x))),
      orderInfo: OrderInfo.fromMap(map['orderInfo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartGroup.fromJson(String source) =>
      CartGroup.fromMap(json.decode(source));
}
