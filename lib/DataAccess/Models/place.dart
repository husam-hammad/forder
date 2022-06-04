import 'dart:convert';

class Place {
  int id;
  String name;
  String adress;
  double lat;
  double long;
  Place({
    required this.id,
    required this.name,
    required this.adress,
    required this.lat,
    required this.long,
  });

  Place copyWith({
    int? id,
    String? name,
    String? adress,
    double? lat,
    double? long,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      adress: adress ?? this.adress,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'adress': adress,
      'lat': lat,
      'long': long,
    };
  }

  Map<String, dynamic> toDBMap() {
    return {
      'name': name,
      'adress': adress,
      'lat': lat,
      'long': long,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      adress: map['adress'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));
}
