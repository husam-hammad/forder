import 'dart:convert';

import 'package:flashorder/DataAccess/Models/captin.dart';
import 'package:flashorder/DataAccess/Models/delivery_state.dart';
import 'package:flashorder/DataAccess/Models/user_order_detail.dart';

class UserOrder {
  int id;
  num value;
  num deliverycost;
  Captin? captin;
  DeliveryState state;
  List<UserOrderDetail> details;
  DateTime? createdAt;
  DateTime? readyAt;
  DateTime? deliveredAt;
  UserOrder({
    required this.id,
    required this.value,
    required this.deliverycost,
    required this.captin,
    required this.state,
    required this.details,
    required this.createdAt,
    required this.readyAt,
    required this.deliveredAt,
  });

  UserOrder copyWith({
    int? id,
    num? value,
    num? deliverycost,
    Captin? captin,
    DeliveryState? state,
    List<UserOrderDetail>? details,
    DateTime? createdAt,
    DateTime? readyAt,
    DateTime? deliveredAt,
  }) {
    return UserOrder(
      id: id ?? this.id,
      value: value ?? this.value,
      deliverycost: deliverycost ?? this.deliverycost,
      captin: captin ?? this.captin,
      state: state ?? this.state,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      readyAt: readyAt ?? this.readyAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
    );
  }

  factory UserOrder.fromMap(Map<String, dynamic> map) {
    return UserOrder(
      id: map['id']?.toInt() ?? 0,
      value: map['value'] ?? 0,
      deliverycost: map['deliverycost'] ?? 0,
      captin: map['captin'] != null ? Captin.fromMap(map['captin']) : null,
      state: DeliveryState.fromMap(map['state']),
      details: List<UserOrderDetail>.from(
          map['details']?.map((x) => UserOrderDetail.fromMap(x))),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'].toString())
          : null,
      readyAt: map['ready_at'] != null
          ? DateTime.parse(map['ready_at'].toString())
          : null,
      deliveredAt: map['delivered_at'] != null
          ? DateTime.parse(map['delivered_at'].toString())
          : null,
    );
  }

  factory UserOrder.fromJson(String source) =>
      UserOrder.fromMap(json.decode(source));
}
