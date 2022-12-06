// ignore_for_file: avoid_print

import 'dart:convert';

class LocationItem {
  double lat;
  double long;
  LocationItem({
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  factory LocationItem.fromMap(Map<String, dynamic> map) {
    print("map is");
    print(map);
    return LocationItem(
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationItem.fromJson(String source) =>
      LocationItem.fromMap(json.decode(source));
}
