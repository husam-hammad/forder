import 'dart:convert';

import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';

class CartItem {
  late int id;
  late int mealId;
  late int restaurentId;
  late Restaurent restaurent;
  late int qty;
  late num price;
  late num allPrice;
  late String specialOrder;
  late String compoments;
  late num replacedPoints;
  late Meal? meal;
  CartItem(
      {required this.id,
      required this.mealId,
      required this.restaurentId,
      required this.qty,
      required this.price,
      required this.allPrice,
      required this.compoments,
      required this.specialOrder,
      required this.replacedPoints});

  CartItem copyWith({
    int? id,
    int? mealId,
    int? qty,
    String? specialOrder,
    DateTime? createdAt,
  }) {
    return CartItem(
        id: id ?? this.id,
        mealId: mealId ?? this.mealId,
        restaurentId: restaurentId,
        qty: qty ?? this.qty,
        price: price,
        allPrice: allPrice,
        compoments: compoments,
        specialOrder: specialOrder ?? this.specialOrder,
        replacedPoints: replacedPoints);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mealId': mealId,
      'restaurentId': restaurentId,
      'qty': qty,
      'price': price,
      'allPrice': allPrice,
      'compoments': compoments,
      'specialOrder': specialOrder,
      'replacedPoints': replacedPoints
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'meal_id': mealId,
      'restaurent_id': restaurentId,
      'qty': qty,
      'price': price,
      'all_price': qty * price,
      'replaced_points': replacedPoints,
      'special_order': specialOrder,
      'compoments': compoments
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
        id: map['id']?.toInt() ?? 0,
        mealId: map['meal_id']?.toInt() ?? 0,
        restaurentId: map['restaurent_id']?.toInt() ?? 0,
        qty: map['qty']?.toInt() ?? 0,
        specialOrder: map['special_order'] ?? '',
        price: map['price']?.toInt() ?? 0,
        compoments: map['compoments'] ?? '',
        allPrice: map['all_price']?.toInt() ?? 0,
        replacedPoints: map['replaced_points'] ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
}
