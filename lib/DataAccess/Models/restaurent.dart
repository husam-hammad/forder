// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/helpers/calc.dart';
import 'package:flashorder/main.dart';

class Restaurent {
  late int id;
  late String name;
  late String logo;
  late String cover;
  late num lat;
  late num long;
  late String adrees;
  late num deliveryCost;
  Restaurent(
      {required this.id,
      required this.name,
      required this.logo,
      required this.cover,
      required this.lat,
      required this.long,
      required this.adrees,
      required this.deliveryCost});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'cover': cover,
      'lat': lat,
      'long': long,
      'adrees': adrees,
      'deliveryCost': 0,
    };
  }

  factory Restaurent.fromMap(Map<String, dynamic> map) {
    return Restaurent(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        logo: map['logo'] ?? '',
        cover: map['cover'] ?? '',
        lat: map['lat'] != null ? num.parse(map['lat']) : 33.5138062,
        long: map['lng'] != null ? num.parse(map['lng']) : 36.2765261,
        adrees: map['adrees'] ?? '',
        deliveryCost: 0);
  }
  num getDeliveryCost() {
    if (MyApp.userPosition != null) {
      double distance = Calc.calculateDistance(lat, long,
          MyApp.userPosition!.latitude, MyApp.userPosition!.longitude);
      /* print("distance : " + distance.toString());
      print("perKmCost : " + MyApp.perKmCost.toString()); */
      num cost = Calc.deliveryCost(distance, MyApp.perKmCost);
      deliveryCost = cost;
/*     print("cost of : " + restaurent.name + cost.toString()); */
      return cost;
    } else {
      return 0;
    }
  }

  String toJson() => json.encode(toMap());

  factory Restaurent.fromJson(String source) =>
      Restaurent.fromMap(json.decode(source));
}
