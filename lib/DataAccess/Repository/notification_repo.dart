// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/notification_client.dart';
/* import 'package:flashorder/Constants/responses.dart'; */
import 'package:flashorder/DataAccess/Models/back_notification.dart';

import '../../Constants/responses.dart';

class NotificationRepo {
  final NotificationClient client;

  NotificationRepo(this.client);

  Future<List<BackNotification>> getall($page) async {
    var response = await client.allNotification($page);
    var map = Map<String, dynamic>.of(json.decode(response));

    if (response != Responses.empty) {
      final parsed =
          json.decode(json.encode(map['data'])).cast<Map<String, dynamic>>();
      return parsed
          .map<BackNotification>((json) => BackNotification.fromMap(json))
          .toList();
    }
    return [];
  }
}
