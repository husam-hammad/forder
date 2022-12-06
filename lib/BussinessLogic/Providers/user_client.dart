// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserClient {
  var client = http.Client();
  var box = GetStorage();
  User? user;
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

  Future<User?> updateUserImage(String userToken, userId, image) async {
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
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "fcmtoken": userfcm,
      }),
    );

    return response.statusCode;
  }

  Future<int> updatePosition(String userToken, userId, lat, lng) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + updateUserPositionUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "lat": lat,
        "lng": lng,
      }),
    );

    return response.statusCode;
  }

  Future<String> getUserPoint(String userToken, userId) async {
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
    return response.body.toString();
  }

  Future<String> getStatus(String userToken, userId) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + getUserStatus);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{"id": userId}),
    );

    return response.body.toString();
  }

  Future<int> requireLocation(String userToken, captinId, userId) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + requireLocationUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "captin_id": captinId,
        "user_id": userId,
      }),
    );

    return response.statusCode;
  }

  Future<int> stopSendLocation(String userToken, captinId, userId) async {
    String headers = "Bearer " + userToken;
    var url = Uri.parse(baseUrl + stopSendLocationUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: headers
      },
      body: jsonEncode(<String, dynamic>{
        "captin_id": captinId,
        "user_id": userId,
      }),
    );

    return response.statusCode;
  }

  Future<int> sendOrderRating(orderid, restauretId, restaurentRating, captinId,
      captinRating, money) async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));

      if (user != null) {
        String headers = "Bearer " + user!.token;
        var url = Uri.parse(baseUrl + postRating);
        var response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: headers
          },
          body: jsonEncode(<String, dynamic>{
            "user_id": user!.id,
            "captin_id": captinId,
            "restaurent_id": restauretId,
            "order_id": orderid,
            "restaurent_rate": restaurentRating,
            "captin_rate": captinRating,
            "user_paid": money
          }),
        );
        return response.statusCode;
      } else {
        return 500;
      }
    } else {
      return 404;
    }
  }
}
