// ignore_for_file: avoid_print

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';
/* import 'package:flutter/foundation.dart'; */
import 'package:http/http.dart' as http;

class MealClient {
  var client = http.Client();

  MealClient();

  Future<dynamic> allmeals($page) async {
    var response = await client
        .get(Uri.parse(baseUrl + allMealsUrl + "?page=" + $page.toString()));
    /* print("MEALS PAGES");
    print(response.body); */
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<dynamic> mealsbyids(ids) async {
    String link = baseUrl + mealsByids + "?ids=" + ids;
    print("link : " + link);
    var response = await client.get(Uri.parse(link));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<dynamic> featuredmeals() async {
    var response = await client.get(Uri.parse(baseUrl + featuredMealsUrl));
    /*   print("MEALS FEATURED");
    print(response.body); */
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<dynamic> offersMeals() async {
    var response = await client.get(Uri.parse(baseUrl + offersMealsUrl));
    /*   print("MEALS FEATURED");
    print(response.body); */
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<dynamic> searchmeal(searchtext) async {
    var response =
        await client.get(Uri.parse(baseUrl + mealSearch + "/" + searchtext));
/*     print(response.body); */
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }
}
