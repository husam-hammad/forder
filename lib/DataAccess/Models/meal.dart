import 'dart:convert';

import 'package:flashorder/DataAccess/Models/restaurent.dart';

class Meal {
  late int id;
  late String name;
  late String image;
  late List<String> components;
  late String description;
  late Restaurent? restaurent;
  late bool available;
  late num price;

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.components,
    required this.description,
    required this.restaurent,
    required this.available,
    required this.price,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      components: map['components'].toString().split(','),
      description: map['description'] ?? "",
      restaurent: map['restaurent'] != null
          ? Restaurent.fromMap(map['restaurent'])
          : null,
      available: map['available'] == 1 ? true : false,
      price: map['price'] ?? 0,
    );
  }

  factory Meal.fromJson(String source) => Meal.fromMap(json.decode(source));
}
