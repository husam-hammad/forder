import 'dart:convert';

class Compliment {
  late int id;
  late int userId;
  late String description;
  late String? reply;
  late DateTime? createdAt;
  late DateTime? repliedAt;
  late int? restaurentId;
  Compliment({
    required this.id,
    required this.userId,
    required this.description,
    required this.reply,
    required this.createdAt,
    required this.repliedAt,
    required this.restaurentId,
  });

  Compliment copyWith({
    int? id,
    int? userId,
    String? description,
    String? reply,
    DateTime? createdAt,
    DateTime? repliedAt,
    int? restaurentId,
  }) {
    return Compliment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      reply: reply ?? this.reply,
      createdAt: createdAt ?? this.createdAt,
      repliedAt: repliedAt ?? this.repliedAt,
      restaurentId: restaurentId ?? this.restaurentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'description': description,
      'restaurentId': restaurentId,
    };
  }

  factory Compliment.fromMap(Map<String, dynamic> map) {
    return Compliment(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      description: map['description'] ?? '',
      reply: map['reply'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'].toString())
          : null,
      repliedAt: map['replied_at'] != null
          ? DateTime.parse(map['replied_at'].toString())
          : null,
      restaurentId: map['restaurentId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
}
