// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/meal_category.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';

class RestaurentRepo {
  final RestaurentClient client;

  RestaurentRepo(this.client);

  Future<List<Restaurent>> getall() async {
    var response = await client.allrestaurents();
    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<Restaurent>((json) => Restaurent.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<Restaurent?> resturentById(id) async {
    var response = await client.restaurentById(id);
    if (response != Responses.empty) {
      return Restaurent.fromMap(json.decode(response));
    }
    return null;
  }

  Future<List<Restaurent>> getNearest($lat, $long) async {
    var response = await client.nearestrestaurents($lat, $long);

    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<Restaurent>((json) => Restaurent.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<int> getRating($id) async {
    var response = await client.getRating($id);
    print(response);
    if (response != Responses.empty) {
      return int.parse(response);
    }
    return 1;
  }

  Future<List<MealCategory>> restaurentMealsCategories(int restaurentId) async {
    var response = await client.restaurentMealsCategories(restaurentId);
    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<MealCategory>((json) => MealCategory.fromMap(json))
          .toList();
    }
    return [];
  }
}
