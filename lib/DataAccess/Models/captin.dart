import 'dart:convert';

class Captin {
  int id;
  String name;
  String phone;
  String avatar;
  double lat;
  double lng;
  Captin({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.lat,
    required this.lng,
  });

  Captin copyWith({
    int? id,
    String? name,
    String? phone,
    String? avatar,
    double? lat,
    double? lng,
  }) {
    return Captin(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Captin.fromMap(Map<String, dynamic> map) {
    return Captin(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      avatar: map['avatar'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Captin.fromJson(String source) => Captin.fromMap(json.decode(source));
}
