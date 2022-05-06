// ignore_for_file: avoid_print

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';

/* import 'package:flutter/foundation.dart'; */
import 'package:http/http.dart' as http;

class SettingClient {
  var client = http.Client();

  SettingClient();

  Future<String> costbyKm() async {
    var response = await client.get(Uri.parse(baseUrl + "settings/costbykm"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }

  Future<String> termsofSse() async {
    var response = await client.get(Uri.parse(baseUrl + "settings/termofuse"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }
}
