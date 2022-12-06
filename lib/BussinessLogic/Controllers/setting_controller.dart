// ignore_for_file: avoid_print

import 'package:flashorder/DataAccess/Repository/setting_repo.dart';
import 'package:flashorder/main.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  late num perKmCost = 0;
  late int allowEditState = 5;
  SettignRepo settignRepo = SettignRepo();
  @override
  void onInit() async {
    super.onInit();
    /* perKmCost = await settignRepo.costbyKm(); */
    /* allowEditState = await settignRepo.orderAllowEditState(); */
    await settignRepo.getSettings();

    perKmCost = MyApp.perKmCost;
    allowEditState = int.parse(MyApp.allowEditState.toString());
    update();
    print("MyApp.perKmCost" + MyApp.perKmCost.toString());
  }
}
