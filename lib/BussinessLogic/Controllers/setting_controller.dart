// ignore_for_file: avoid_print

import 'package:flashorder/DataAccess/Repository/setting_repo.dart';
import 'package:flashorder/main.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  late num perKmCost;
  SettignRepo settignRepo = SettignRepo();
  @override
  void onInit() async {
    super.onInit();
    perKmCost = await settignRepo.costbyKm();
    MyApp.perKmCost = perKmCost;
  }
}
