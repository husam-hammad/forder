import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/complimnet_client.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/compliments.dart';

class ComplimentRepo {
  ComplimentClient client;
  ComplimentRepo(this.client);

  Future<List<Compliment>> getAll(userToken, userID) async {
    var response = await client.getCompliments(userToken, userID);
    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      // ignore: avoid_print
      return parsed
          .map<Compliment>((json) => Compliment.fromMap(json))
          .toList();
    }
    return [];
  }

  Future<bool> sendCompliment(tosend, userToken) async {
    var response = await client.sendCompliment(tosend, userToken);

    if (response == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deleteCompliment(id, userToken) async {
    var response = await client.deleteCompliment(id, userToken);

    if (response == 200) {
      return true;
    }
    return false;
  }
}
