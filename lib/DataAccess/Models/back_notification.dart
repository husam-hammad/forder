import 'dart:convert';

import 'package:flashorder/DataAccess/Models/notification_user.dart';

class BackNotification {
  int id;
  String title;
  String description;
  NotificationUser from;
  String modelName;
  String modelId;
  DateTime createdAt;
  BackNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.from,
    required this.modelName,
    required this.modelId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'from': from.toMap(),
      'modelName': modelName,
      'modelId': modelId,
    };
  }

  factory BackNotification.fromMap(Map<String, dynamic> map) {
    return BackNotification(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      from: NotificationUser.fromMap(map['from']),
      modelName: map['modelName'] ?? '',
      modelId: map['modelId'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BackNotification.fromJson(String source) =>
      BackNotification.fromMap(json.decode(source));
}
