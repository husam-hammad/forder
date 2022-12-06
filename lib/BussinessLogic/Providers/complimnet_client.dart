// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ComplimentClient {
  var client = http.Client();
  var box = GetStorage();
  User? user;
  ComplimentClient();

  Future<int> sendCompliment(dynamic tosend, String userToken) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + newComplimentUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{"data": tosend}),
    );
    print(response.body);
    return response.statusCode;
  }

  Future<int> deleteCompliment(id, String userToken) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + deleteComplimentUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{"id": id}),
    );
    return response.statusCode;
  }

  Future<dynamic> getCompliments(String userToken, userID) async {
    String headers = "Bearer " + userToken;
    var response = await client.get(
        Uri.parse(
          baseUrl + complimentUrl + "/$userID",
        ),
        headers: {HttpHeaders.authorizationHeader: headers});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }
}
