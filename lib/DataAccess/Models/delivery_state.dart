import 'dart:convert';

class DeliveryState {
  int id;
  String name;
  String color;
  String image;
  int order;
  DeliveryState(
      {required this.id,
      required this.name,
      required this.color,
      required this.image,
      required this.order});

  factory DeliveryState.fromMap(Map<String, dynamic> map) {
    return DeliveryState(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        color: map['color'] ?? '',
        image: map['image'] ?? '',
        order: map['order'] ?? 0);
  }
  factory DeliveryState.fromJson(String source) =>
      DeliveryState.fromMap(json.decode(source));
}
