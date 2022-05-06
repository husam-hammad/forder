import 'dart:convert';

import 'package:flashorder/DataAccess/Models/meal.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';

class MealCategory {
  late int id;
  late String name;
  late List<Meal>? meals;
  late Restaurent? restaurent;
  MealCategory({
    required this.id,
    required this.name,
    required this.meals,
    required this.restaurent,
  });

  factory MealCategory.fromMap(Map<String, dynamic> map) {
    List<Meal> mealsfromJson(String json) {
      final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
      // ignore: avoid_print
      print(parsed);
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }

    return MealCategory(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? "",
      meals:
          map['meals'] != null ? mealsfromJson(jsonEncode(map['meals'])) : null,
      restaurent: Restaurent.fromMap(map['restaurent']),
    );
  }

  List<Meal> mealsfromJson(String json) {
    final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
  }
}
