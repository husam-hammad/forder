import 'dart:convert';

import 'package:flashorder/DataAccess/Models/restaurent.dart';

class Order {
  late int id;
  late int userId;
  late int restaurentId;
  late Restaurent restaurent;
  late num allValue;
  late num discount;
  late num netValue;
  late num deliveryCost;
  Order({
    required this.id,
    required this.userId,
    required this.restaurentId,
    required this.allValue,
    required this.discount,
    required this.netValue,
    required this.deliveryCost,
  });

  Order copyWith({
    int? id,
    int? userId,
    int? restaurentId,
    num? allValue,
    num? discount,
    num? netValue,
    num? deliveryCost,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurentId: restaurentId ?? this.restaurentId,
      allValue: allValue ?? this.allValue,
      discount: discount ?? this.discount,
      netValue: netValue ?? this.netValue,
      deliveryCost: deliveryCost ?? this.deliveryCost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'restaurentId': restaurentId,
      'allValue': allValue,
      'discount': discount,
      'netValue': netValue,
      'deliveryCost': deliveryCost,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      restaurentId: map['restaurentId']?.toInt() ?? 0,
      allValue: map['allValue'] ?? 0,
      discount: map['discount'] ?? 0,
      netValue: map['netValue'] ?? 0,
      deliveryCost: map['deliveryCost'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
