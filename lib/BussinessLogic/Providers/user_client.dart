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
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromApiMap(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<User?> updateUserImage(String userToken, userId, image) async {
    print('start post users');
    String headers = "Bearer " + userToken;
    /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, */
    var url = Uri.parse(baseUrl + updateUserImageUrl);
    /* var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "name": name,
        "phone": phone,
        "birthday": birthday,
        "adress": adress,
      }),
    ); */

    var request = http.MultipartRequest("POST", url)
      ..fields.addAll(<String, String>{
        "userId": userId.toString(),
        "avatar": image,
      })
      ..headers.addAll(<String, String>{
        'Content-Type': 'multipart/form-data',
        HttpHeaders.authorizationHeader: headers
      })
      ..files.add(await http.MultipartFile.fromPath('avatar', image));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('200');
      return User.fromApiMap(jsonDecode(await response.stream.bytesToString()));
    }
    return null;
  }

  Future<User?> updateUserInfo(
      String userToken, userId, name, phone, birthday, adress) async {
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
        "birthday": birthday,
        "adress": adress,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromApiMap(jsonDecode(response.body));
    }
    return null;
  }

  Future<int> updateFCM(String userToken, userfcm, userId) async {
    print("user Id Is : " + userId.toString());
    print("user FCM Is : " + userfcm.toString());
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + updateFCMUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "fcmtoken": userfcm,
      }),
    );

    print(response.statusCode);
    return response.statusCode;
  }

  Future<String> getUserPoint(String userToken, userId) async {
    print("start get user points 0");
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + getUserPoints);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{"userId": userId}),
    );
    print(response.body);
    return response.body.toString();
  }
}
