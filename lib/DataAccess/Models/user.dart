import 'dart:convert';

class User {
  late int id;
  late String phone;
  late String avatar;
  late double points;
  late String token;
  late String birthday;
  late bool statue;
  User({
    required this.id,
    required this.phone,
    required this.avatar,
    required this.points,
    required this.token,
    required this.birthday,
    required this.statue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'avatar': avatar,
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
      avatar: map['avatar'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      token: map['token'] ?? '',
      birthday: map['birthday'] ?? '',
      statue: map['statue'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
