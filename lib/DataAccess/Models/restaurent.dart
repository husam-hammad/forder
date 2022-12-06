// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/DataAccess/Models/tax.dart';
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
  late num distance = 0;
  late bool status;
  late int rating = 3;
  late int? percentType;
  late List<Tax>? taxs;
  late num? addonValue;
  late int isOpen;
  final int worldcup;
  Restaurent({
    required this.id,
    required this.name,
    required this.logo,
    required this.cover,
    required this.lat,
    required this.long,
    required this.adrees,
    required this.deliveryCost,
    required this.status,
    this.percentType,
    required this.taxs,
    required this.addonValue,
    required this.isOpen,
    required this.worldcup,
  });

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
      adrees: map['adress'] ?? '',
      status: map['statue'] ?? true,
      deliveryCost: 0,
      percentType: map['percent_type'],
      taxs: map['taxs'] != null ? taxfromJson(jsonEncode(map['taxs'])) : null,
      addonValue: map['addonValue'] == null ||
              map['addonValue'] == "null" ||
              map['addonValue'] == 0 ||
              map['addonValue'] == "0"
          ? null
          : num.parse(map['addonValue'].toString()),
      isOpen: map['isOpen'] ?? 0,
      worldcup: map['worldcup'] ?? 0,
    );
  }
  static List<Tax> taxfromJson(json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed.map<Tax>((json) => Tax.fromMap(json)).toList();
  }

  num getDeliveryCost() {
    if (MyApp.userPosition != null) {
      double distance = Calc.calculateDistance(lat, long,
          MyApp.userPosition!.latitude, MyApp.userPosition!.longitude);
      /* print("distance : " + distance.toString());
      print("perKmCost : " + MyApp.perKmCost.toString()); */
      this.distance = num.parse(distance.toStringAsFixed(2)) * 150 / 100;
      this.distance = num.parse(this.distance.toStringAsFixed(2));
      num cost = Calc.deliveryCost(this.distance, MyApp.perKmCost);
      if (cost < MyApp.minDeliveryCost) {
        cost = MyApp.minDeliveryCost;
      }
      deliveryCost = cost;
      return cost;
    } else {
      return 0;
    }
  }

  String toJson() => json.encode(toMap());

  factory Restaurent.fromJson(String source) =>
      Restaurent.fromMap(json.decode(source));
}
