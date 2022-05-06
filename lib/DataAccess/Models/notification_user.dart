import 'dart:convert';

class NotificationUser {
  int id;
  String name;
  String avatar;
  NotificationUser({
    required this.id,
    required this.name,
    required this.avatar,
  });

  NotificationUser copyWith({
    int? id,
    String? name,
    String? avatar,
  }) {
    return NotificationUser(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  factory NotificationUser.fromMap(Map<String, dynamic> map) {
    return NotificationUser(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationUser.fromJson(String source) =>
      NotificationUser.fromMap(json.decode(source));
}
