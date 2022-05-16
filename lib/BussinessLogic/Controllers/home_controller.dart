// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/fcm_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  late Position position;
  late GetStorage box;
  final FCMController fcmController = Get.find();
  late User user;
  final userClient = UserClient();
  @override
  void onInit() async {
    super.onInit();
    box = GetStorage();

    position = await determinePosition();
    MyApp.userPosition = position;

    await box.write('position', position);
    await updateFCM();
  }

  Future<void> updateFCM() async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
      var userfcm = fcmController.fcmtoken;
      print("userfcm " + userfcm!);
      await userClient.updateFCM(user.token, userfcm, user.id);
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      while (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    /* if (permission == LocationPermission.denied) {
      
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } */

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
