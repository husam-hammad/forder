// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flashorder/BussinessLogic/Providers/settings_client.dart';
/* import 'package:flashorder/main.dart'; */

import '../../Constants/responses.dart';
import '../../main.dart';

class SettignRepo {
  SettingClient settingClient = SettingClient();

  getSettings() async {
    var response = await settingClient.getSettings();
    if (response != Responses.empty) {
      final parsed = json.decode(response);
      print(parsed);
      print(parsed['costbyKm'].toString());
      MyApp.perKmCost = num.parse(parsed['costbyKm'].toString());
      MyApp.minDeliveryCost = num.parse(parsed['min_delivery_cost'].toString());
      MyApp.allowEditState =
          num.parse(parsed["orderAllowEditionState"].toString());
      MyApp.pointcost = num.parse(parsed["pointcost"].toString());
      MyApp.settingAppVersion = parsed["app_version"].toString();
      MyApp.settingMandatoryUpdate =
          parsed["mandatory_update"] == "1" ? true : false;
      print("settingMandatoryUpdate");
      print(MyApp.settingMandatoryUpdate);
    }
  }

  Future<num> costbyKm() async {
    return num.parse(await settingClient.costbyKm());
  }

  Future<int> orderAllowEditState() async {
    return int.parse(await settingClient.orderAllowEditionState());
  }
}
