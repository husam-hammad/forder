// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/notification_client.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/back_notification.dart';

class NotificationRepo {
  final NotificationClient client;

  NotificationRepo(this.client);

  Future<List<BackNotification>> getall() async {
    var response = await client.allNotification();
    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<BackNotification>((json) => BackNotification.fromMap(json))
          .toList();
    }
    return [];
  }
}
