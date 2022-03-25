// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/restaurent_client.dart';
import 'package:flashorder/Constants/responses.dart';
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
}
