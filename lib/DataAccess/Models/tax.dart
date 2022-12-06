import 'dart:convert';

class Tax {
  final int id;
  final String name;
  final double taxValue;
  final num round;
  Tax({
    required this.id,
    required this.name,
    required this.taxValue,
    required this.round,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'taxValue': taxValue,
    };
  }

  factory Tax.fromMap(Map<String, dynamic> map) {
    return Tax(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      taxValue: map['tax_value']?.toDouble() ?? 0.0,
      round: map['round'] != null ? num.parse(map['round'].toString()) : 10,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tax.fromJson(String source) => Tax.fromMap(json.decode(source));
}
