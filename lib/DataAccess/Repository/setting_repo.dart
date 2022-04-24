import 'package:flashorder/BussinessLogic/Providers/settings_client.dart';

class SettignRepo {
  SettingClient settingClient = SettingClient();

  Future<num> costbyKm() async {
    return num.parse(await settingClient.costbyKm());
  }
}
