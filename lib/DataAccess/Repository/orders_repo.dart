// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/order_client.dart';
import 'package:flashorder/Constants/responses.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';

class OrderRepo {
  final OrderClient client;

  OrderRepo(this.client);

  Future<List<UserOrder>> getall() async {
    var response = await client.getOrders();

    if (response != Responses.empty) {
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed.map<UserOrder>((json) => UserOrder.fromMap(json)).toList();
    }
    return [];
  }
}
