import 'dart:convert';

import 'package:flashorder/DataAccess/Models/meal.dart';

class UserOrderDetail {
  int id;
  Meal meal;
  num qty;
  num price;
  num allPrice;
  String special;
  String compoments;
  String allInOne;
  UserOrderDetail({
    required this.id,
    required this.meal,
    required this.qty,
    required this.price,
    required this.allPrice,
    required this.special,
    required this.compoments,
    required this.allInOne,
  });

  UserOrderDetail copyWith({
    int? id,
    Meal? meal,
    num? qty,
    num? price,
    num? allPrice,
    String? special,
    String? compoments,
    String? allInOne,
  }) {
    return UserOrderDetail(
      id: id ?? this.id,
      meal: meal ?? this.meal,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      allPrice: allPrice ?? this.allPrice,
      special: special ?? this.special,
      compoments: compoments ?? this.compoments,
      allInOne: allInOne ?? this.allInOne,
    );
  }

  factory UserOrderDetail.fromMap(Map<String, dynamic> map) {
    return UserOrderDetail(
      id: map['id']?.toInt() ?? 0,
      meal: Meal.fromMap(map['meal']),
      qty: map['qty'] ?? 0,
      price: map['price'] ?? 0,
      allPrice: map['allPrice'] ?? 0,
      special: map['special'] ?? '',
      compoments: map['compoments'] ?? '',
      allInOne: map['all_in_one'] ?? '',
    );
  }

  factory UserOrderDetail.fromJson(String source) =>
      UserOrderDetail.fromMap(json.decode(source));
}
