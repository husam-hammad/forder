import 'dart:convert';

class User {
  late int id;
  late String phone;
  late num points;
  late String token;
  late String birthday;
  late bool statue;
  late String avatar;
  User({
    required this.id,
    required this.phone,
    required this.points,
    required this.token,
    required this.birthday,
    required this.statue,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'points': points,
      'token': token,
      'birthday': birthday,
      'statue': statue,
      'avatar': avatar,
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
        avatar: map['avatar'] ?? '');
  }
  /*
user": {
        "name": "0937143734",
        "email": "0937143734",
        "updated_at": "2022-04-27T15:23:41.000000Z",
        "created_at": "2022-04-27T15:23:41.000000Z",
        "id": 10
    },
    "token": "3|Vv71ARapNKeLO9HKtUCgx72HJkXuwUgXXrsuP0e3"
  */
  factory User.fromApiMap(Map<String, dynamic> map) {
    return User(
      id: map['user']['id']?.toInt() ?? 0,
      phone: map['user']['email'] ?? '',
      points:
          map['user']['points'] != null ? num.parse(map['user']['points']) : 0,
      token: map['token'] ?? '',
      birthday: map['birthday'] ?? '',
      statue: map['statue'] ?? false,
      avatar: map['birthday'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
