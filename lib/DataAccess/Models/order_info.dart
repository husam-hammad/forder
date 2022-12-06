import 'dart:convert';

class OrderInfo {
  int? userId;
  int? restaurentId;
  double? pLat;
  double? pLong;
  num? orderValue;
  num? deliveryCost;
  String? adress;
  num? usedpoints;
  OrderInfo(
      {this.userId,
      this.restaurentId,
      this.pLat,
      this.pLong,
      this.orderValue,
      this.deliveryCost,
      this.adress,
      this.usedpoints});

  OrderInfo copyWith({
    int? userId,
    int? restaurentId,
    double? pLat,
    double? pLong,
    num? orderValue,
    num? deliveryCost,
  }) {
    return OrderInfo(
      userId: userId ?? this.userId,
      restaurentId: restaurentId ?? this.restaurentId,
      pLat: pLat ?? this.pLat,
      pLong: pLong ?? this.pLong,
      orderValue: orderValue ?? this.orderValue,
      deliveryCost: deliveryCost ?? this.deliveryCost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'restaurentId': restaurentId,
      'pLat': pLat,
      'pLong': pLong,
      'orderValue': orderValue,
      'deliveryCost': deliveryCost,
      'adress': adress,
      'usedpoints': usedpoints
    };
  }

  factory OrderInfo.fromMap(Map<String, dynamic> map) {
    return OrderInfo(
        userId: map['userId']?.toInt(),
        restaurentId: map['restaurentId']?.toInt(),
        pLat: map['pLat']?.toDouble(),
        pLong: map['pLong']?.toDouble(),
        orderValue: map['orderValue'],
        deliveryCost: map['deliveryCost'],
        adress: map['adress'],
        usedpoints: map['usedpoints']);
  }

  String toJson() => json.encode(toMap());

  factory OrderInfo.fromJson(String source) =>
      OrderInfo.fromMap(json.decode(source));
}
