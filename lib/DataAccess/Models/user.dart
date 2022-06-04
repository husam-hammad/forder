// ignore_for_file: avoid_print

import 'dart:convert';

class User {
  late int id;
  late String name;
  late String phone;
  late num points;
  late String token;
  late DateTime? birthday;
  late String? adress;
  late bool statue;
  late String avatar;
  User(
      {required this.id,
      required this.name,
      required this.phone,
      required this.points,
      required this.token,
      required this.birthday,
      required this.statue,
      required this.avatar,
      required this.adress});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'points': points,
      'token': token,
      'birthday': birthday.toString(),
      'statue': statue,
      'avatar': avatar,
      'adress': adress,
    };
  }

  Map<String, dynamic> toBoxMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'points': points,
      'token': token,
      'birthday': birthday.toString(),
      'statue': statue,
      'avatar': avatar,
      'adress': adress,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    /*  print("start map" + map.toString()); */
    DateTime? testbirth() {
      try {
        return DateTime.parse(map['birthday'].toString());
      } catch (e) {
        return null;
      }
    }

    //print(map['birthday']);
    return User(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        points: map['points']?.toDouble() ?? 0,
        token: map['token'] ?? '',
        birthday: (map['birthday'] != null && map['birthday'] != "")
            ? testbirth()
            : null,
        // birthday: null,
        adress: map['adress'] ?? '',
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
    //print(map['user']['birthday']);
    return User(
      id: map['user']['id']?.toInt() ?? 0,
      phone: map['user']['email'] ?? '',
      name: map['user']['name'] ?? '',
      points: map['user']['points'] ?? 0,
      token: map['token'] ?? '',
      adress: map['user']['adress'] ?? '',
      birthday:
          (map['user']['birthday'] != "" && map['user']['birthday'] != null)
              ? DateTime.parse(map['user']['birthday'])
              : null,
      statue: map['statue'] ?? false,
      avatar: map['user']['avatar'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
