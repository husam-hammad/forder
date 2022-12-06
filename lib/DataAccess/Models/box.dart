import 'dart:convert';

import 'package:flashorder/DataAccess/Models/box_detail.dart';

class Box {
  final int id;
  final String title;
  final String image;
  final num orderValue;
  final num discount;
  final num finalValue;
  final List<BoxDetail>? details;
  Box({
    required this.id,
    required this.title,
    required this.image,
    required this.orderValue,
    required this.discount,
    required this.finalValue,
    this.details,
  });

  factory Box.fromMap(Map<String, dynamic> map) {
    return Box(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      orderValue: map['orderValue'] ?? 0,
      discount: map['discount'] ?? 0,
      finalValue: map['finalValue'] ?? 0,
      details: map['details'] != null
          ? detailsfromJson(jsonEncode(map['details']))
          : null,
    );
  }

  static List<BoxDetail> detailsfromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed.map<BoxDetail>((json) => BoxDetail.fromMap(json)).toList();
  }
}
