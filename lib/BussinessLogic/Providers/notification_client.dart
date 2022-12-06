// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flashorder/Constants/links.dart';
/* import 'package:flashorder/Constants/responses.dart'; */
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flashorder/Constants/responses.dart';

class NotificationClient {
  var client = http.Client();
  var box = GetStorage();
  User? user;
  NotificationClient();
  Future<dynamic> allNotification($page) async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
    }

    if (user != null) {
      String token = user!.token;
      String headers = "Bearer " + token;
      var response = await client.get(
          Uri.parse(baseUrl + notificationsUrl + "?page=" + $page.toString()),
          headers: {HttpHeaders.authorizationHeader: headers});
      /* print(response.body); */
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Responses.empty;
      }
    } else {
      return Responses.empty;
    }
  }
}
