// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';
/* import 'package:flutter/foundation.dart'; */
import 'package:http/http.dart' as http;

class MatchClient {
  var client = http.Client();

  MatchClient();

  Future<dynamic> allmatches() async {
    var response = await client.get(Uri.parse(baseUrl + matches));
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<int> getTable(String userToken, userId, restaurentId, persons) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + worldCupTable);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": userId,
        "restaurent_id": restaurentId,
        "persons": persons,
      }),
    );
    print(response.body);
    return response.statusCode;
  }
}
