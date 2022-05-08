// ignore_for_file: avoid_print

import 'package:flashorder/Constants/links.dart';
import 'package:flashorder/Constants/responses.dart';

/* import 'package:flutter/foundation.dart'; */
import 'package:http/http.dart' as http;

class StoryClient {
  var client = http.Client();

  StoryClient();

  Future<dynamic> allstories() async {
    var response = await client.get(Uri.parse(baseUrl + allStoriesUrl));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Responses.empty;
    }
  }
}
