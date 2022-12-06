// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/DataAccess/Models/restaurent.dart';

class Meal {
  late int id;
  late String name;
  late String image;
  late int categoryId;
  late List<String> components;
  late String description;
  late Restaurent? restaurent;
  late bool available;
  late num price;
  late num offerPrice;
  late int featured;
  late num categoryDiscount;
  late num restaurentDiscount;
  late num points;
  late int isOpen;
  Meal(
      {required this.id,
      required this.name,
      required this.image,
      required this.categoryId,
      required this.components,
      required this.description,
      required this.restaurent,
      required this.available,
      required this.price,
      required this.featured,
      required this.offerPrice,
      required this.categoryDiscount,
      required this.restaurentDiscount,
      required this.points,
      required this.isOpen});

  factory Meal.fromMap(Map<String, dynamic> map) {
    print(map['points']);
    return Meal(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      categoryId: map['categoryId'] ?? 0,
      components: map['components'].toString() != ""
          ? map['components'].toString().split(',')
          : List.empty(),
      description: map['description'] ?? "",
      restaurent: (map['restaurent'] != null && map['restaurent'] is! int)
          ? Restaurent.fromMap(map['restaurent'])
          : null,
      available: map['available'] == 1 ? true : false,
      price: map['price'] ?? 0,
      featured: map['featured'] ?? 0,
      offerPrice: map['offer_price'] ?? 0,
      categoryDiscount: map['categoryDiscount'] ?? 0,
      restaurentDiscount: map['restaurentDiscount'] ?? 0,
      points: map['points'] ?? 0,
      isOpen: map['isOpen'] ?? 0,
    );
  }

  factory Meal.fromJson(String source) => Meal.fromMap(json.decode(source));
}
