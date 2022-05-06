// ignore_for_file: avoid_print

import 'dart:convert';

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
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromApiMap(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<User?> updateUserInfo(username, password) async {
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
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromApiMap(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
