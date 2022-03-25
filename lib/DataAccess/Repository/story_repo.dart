// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flashorder/BussinessLogic/Providers/stories_client.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/story.dart';

class StoryRepo {
  final StoryClient client;

  StoryRepo(this.client);

  Future<List<Story>> getall() async {
    var response = await client.allstories();
    if (response != Responses.empty) {
      print(response);
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Story>((json) => Story.fromMap(json)).toList();
    }
    return [];
  }
}
