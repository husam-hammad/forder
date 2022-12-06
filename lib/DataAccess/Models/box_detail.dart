import 'package:flashorder/DataAccess/Models/meal.dart';

class BoxDetail {
  final int id;
  final Meal meal;
  final int qty;
  final num price;
  final num allPrice;
  BoxDetail({
    required this.id,
    required this.meal,
    required this.qty,
    required this.price,
    required this.allPrice,
  });

  BoxDetail copyWith({
    int? id,
    Meal? meal,
    int? qty,
    num? price,
    num? allPrice,
  }) {
    return BoxDetail(
      id: id ?? this.id,
      meal: meal ?? this.meal,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      allPrice: allPrice ?? this.allPrice,
    );
  }

  factory BoxDetail.fromMap(Map<String, dynamic> map) {
    return BoxDetail(
      id: map['id']?.toInt() ?? 0,
      meal: Meal.fromMap(map['meal']),
      qty: map['qty']?.toInt() ?? 0,
      price: map['price'] ?? 0,
      allPrice: map['allPrice'] ?? 0,
    );
  }
}
