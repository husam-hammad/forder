// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderClient {
  var client = http.Client();
  var box = GetStorage();
  User? user;
  Future<bool> sendOrder(dynamic tosend, oldOrderId) async {
    var url = Uri.parse(baseUrl + postOrderUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, dynamic>{"data": tosend, "order_id": oldOrderId}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == "1") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> sendBox(dynamic tosend) async {
    var url = Uri.parse(baseUrl + postBoxrUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"data": tosend}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == "1") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<dynamic> getOrders() async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));

      if (user != null) {
        String token = user!.token;
        String headers = "Bearer " + token;
        var response = await client.get(
            Uri.parse(
              baseUrl + ordersUrl,
            ),
            headers: {HttpHeaders.authorizationHeader: headers});
        print(response.body);
        if (response.statusCode == 200) {
          return response.body;
        } else {
          return Responses.empty;
        }
      } else {
        return Responses.empty;
      }
    } else {
      return Responses.empty;
    }
  }
}
