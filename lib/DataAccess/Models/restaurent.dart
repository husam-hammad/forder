import 'dart:convert';

class Restaurent {
  late int id;
  late String name;
  late String logo;
  late String cover;
  late double lat;
  late double long;
  late String adrees;
  Restaurent({
    required this.id,
    required this.name,
    required this.logo,
    required this.cover,
    required this.lat,
    required this.long,
    required this.adrees,
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
    };
  }

  factory Restaurent.fromMap(Map<String, dynamic> map) {
    return Restaurent(
      id: map['data']['id']?.toInt() ?? 0,
      name: map['data']['name'] ?? '',
      logo: map['data']['logo'] ?? '',
      cover: map['data']['cover'] ?? '',
      lat: map['data']['lat'] ?? 0,
      long: map['data']['long'] ?? 0,
      adrees: map['data']['adrees'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurent.fromJson(String source) =>
      Restaurent.fromMap(json.decode(source));
}
