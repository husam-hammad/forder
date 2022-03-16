import 'dart:convert';

class Restaurent {
  final int id;
  final String name;
  final String imageUrl;
  late double lat;
  late double long;
  late String adrees;
  Restaurent({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lat,
    required this.long,
    required this.adrees,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'lat': lat,
      'long': long,
      'adrees': adrees,
    };
  }

  factory Restaurent.fromMap(Map<String, dynamic> map) {
    return Restaurent(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      lat: map['lat'] ?? 0,
      long: map['long'] ?? 0,
      adrees: map['adrees'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurent.fromJson(String source) =>
      Restaurent.fromMap(json.decode(source));
}
