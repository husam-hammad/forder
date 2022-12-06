// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/meal_client.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/meal.dart';

class MealRepo {
  final MealClient client;

  MealRepo(this.client);

  Future<List<Meal>> getall($page) async {
    var response = await client.allmeals($page);
/*     var map = Map<String, dynamic>.of(json.decode(response)); */
    if (response != Responses.empty) {
      /*  final parsed =
          json.decode(json.encode(map['data'])).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList(); */
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Meal>> featuredMeals() async {
    var response = await client.featuredmeals();
/*     var map = Map<String, dynamic>.of(json.decode(response)); */
    if (response != Responses.empty) {
      /*  final parsed =
          json.decode(json.encode(map['data'])).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList(); */
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Meal>> offersMeals() async {
    var response = await client.offersMeals();
/*     var map = Map<String, dynamic>.of(json.decode(response)); */
    if (response != Responses.empty) {
      /*  final parsed =
          json.decode(json.encode(map['data'])).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList(); */
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Meal>> mealsbyids(ids) async {
    var response = await client.mealsbyids(ids);
/*     var map = Map<String, dynamic>.of(json.decode(response)); */
    if (response != Responses.empty) {
      /*  final parsed =
          json.decode(json.encode(map['data'])).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList(); */
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Meal>> getPages($page) async {
    var response = await client.allmeals($page);
    var map = Map<String, dynamic>.of(json.decode(response));
    print(map);
    if (response != Responses.empty) {
      final parsed =
          json.decode(json.encode(map['data'])).cast<Map<String, dynamic>>();
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }
    return [];
  }

  Future<List<Meal>> getSearch(text) async {
    var response = await client.searchmeal(text);
    print(response);
    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      print("start retuen");
      return parsed.map<Meal>((json) => Meal.fromMap(json)).toList();
    }
    return [];
  }
}
