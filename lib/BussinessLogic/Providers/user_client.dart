// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:http/http.dart' as http;

class UserClient {
  var client = http.Client();

  Future<User?> register(username, password) async {
    var url = Uri.parse(baseUrl + registerUrl);

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': username,
        'email': username,
        'password': password,
        'password_confirmation': password,
      }),
    );
    if (response.statusCode == 200) {
      return User.fromApiMap(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<User?> updateUserInfo(
      String userToken, userId, name, phone, birthday) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + updateUserInfoUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "name": name,
        "phone": phone,
        "birthday": birthday
      }),
    );
    if (response.statusCode == 200) {
      return User.fromApiMap(jsonDecode(response.body));
    }
    return null;
  }

  Future<int> updateFCM(String userToken, userfcm, userId) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + updateFCMUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body:
          jsonEncode(<String, dynamic>{"userId": userId, "fcmtoken": userfcm}),
    );
    print(response.statusCode);
    return response.statusCode;
  }
}
