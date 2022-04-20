import 'dart:convert';

class OrderDetail {
  final int id;
  final int orderId;
  final int restaurentId;
  final int mealId;
  final int qty;
  final num price;
  final num allPrice;
  final String specialOrder;
  final String compoments;
  OrderDetail({
    required this.id,
    required this.orderId,
    required this.restaurentId,
    required this.mealId,
    required this.qty,
    required this.price,
    required this.allPrice,
    required this.specialOrder,
    required this.compoments,
  });

  OrderDetail copyWith({
    int? id,
    int? orderId,
    int? restaurentId,
    int? mealId,
    int? qty,
    num? price,
    num? allPrice,
    String? specialOrder,
    String? compoments,
  }) {
    return OrderDetail(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      restaurentId: restaurentId ?? this.restaurentId,
      mealId: mealId ?? this.mealId,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      allPrice: allPrice ?? this.allPrice,
      specialOrder: specialOrder ?? this.specialOrder,
      compoments: compoments ?? this.compoments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'restaurentId': restaurentId,
      'mealId': mealId,
      'qty': qty,
      'price': price,
      'allPrice': allPrice,
      'specialOrder': specialOrder,
      'compoments': compoments,
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      restaurentId: map['restaurentId']?.toInt() ?? 0,
      mealId: map['mealId']?.toInt() ?? 0,
      qty: map['qty']?.toInt() ?? 0,
      price: map['price'] ?? 0,
      allPrice: map['allPrice'] ?? 0,
      specialOrder: map['specialOrder'] ?? '',
      compoments: map['compoments'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetail(id: $id, orderId: $orderId, restaurentId: $restaurentId, mealId: $mealId, qty: $qty, price: $price, allPrice: $allPrice, specialOrder: $specialOrder, compoments: $compoments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetail &&
        other.id == id &&
        other.orderId == orderId &&
        other.restaurentId == restaurentId &&
        other.mealId == mealId &&
        other.qty == qty &&
        other.price == price &&
        other.allPrice == allPrice &&
        other.specialOrder == specialOrder &&
        other.compoments == compoments;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        restaurentId.hashCode ^
        mealId.hashCode ^
        qty.hashCode ^
        price.hashCode ^
        allPrice.hashCode ^
        specialOrder.hashCode ^
        compoments.hashCode;
  }
}
