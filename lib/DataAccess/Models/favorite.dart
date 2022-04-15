// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Favorite {
  final String tableFavorite = "favorites";
  final int id;
  final int meal_id;
  Favorite({
    required this.id,
    required this.meal_id,
  });

  Favorite copyWith({
    int? id,
    int? mealId,
  }) {
    return Favorite(
      id: id ?? this.id,
      meal_id: mealId ?? meal_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      /* 'id': id, */
      'meal_id': meal_id
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id']?.toInt() ?? 0,
      meal_id: map['meal_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source));
}
