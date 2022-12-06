import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/match_client.dart';
import 'package:flashorder/DataAccess/Models/match.dart';
import 'package:get_storage/get_storage.dart';

import '../../Constants/responses.dart';
import '../Models/user.dart';

class MatchesRepo {
  MatchClient client = MatchClient();
  var box = GetStorage();
  User? user;
  Future<List<Match>> getMatches() async {
    var response = await client.allmatches();
    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<Match>((json) => Match.fromMap(json)).toList();
    }
    return [];
  }

  Future<bool> sendTableRequest(restaurentId, persons) async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
    }

    if (user != null) {
      if (await client.getTable(user!.token, user!.id, restaurentId, persons) ==
          200) {
        return true;
      }
    }
    return false;
  }
}
