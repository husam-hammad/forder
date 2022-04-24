import 'dart:convert';

class User {
  late int id;
  late String phone;
  late double points;
  late String token;
  late String birthday;
  late bool statue;
  User({
    required this.id,
    required this.phone,
    required this.points,
    required this.token,
    required this.birthday,
    required this.statue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'points': points,
      'token': token,
      'birthday': birthday,
      'statue': statue,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      phone: map['phone'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      token: map['token'] ?? '',
      birthday: map['birthday'] ?? '',
      statue: map['statue'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
