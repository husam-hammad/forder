// ignore_for_file: avoid_print

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';

/* import 'package:flutter/foundation.dart'; */
import 'package:http/http.dart' as http;

class RestaurentClient {
  var client = http.Client();

  RestaurentClient();

  Future<dynamic> allrestaurents() async {
    var response = await client.get(Uri.parse(baseUrl + allRestaurentsUrl));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<dynamic> restaurentMealsCategories(int restaurentId) async {
    var response = await client.get(
        Uri.parse(baseUrl + restaurentcategoriesUrl + restaurentId.toString()));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  /*
Future<List<Restaurent>> allrestaurents() async {
    print('statrt Client');
    var response = await client.get(Uri.parse(baseUrl + allRestaurentsUrl));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<Restaurent>((json) => Restaurent.fromMap(json))
          .toList();
    } else {
      return [];
    }
  }
  */
}
