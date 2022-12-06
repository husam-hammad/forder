// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flashorder/BussinessLogic/Controllers/fcm_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/stories_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/main.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../Constants/routes.dart';

class HomeController extends GetxController {
  Position? position;
  late GetStorage box;
  late String currentTimeAmPm = "";
  final FCMController fcmController = Get.find();
  final PlacesController placesController = Get.find();
  final UserController userController = Get.find();

  late User user;
  final userClient = UserClient();
  @override
  void onInit() async {
    super.onInit();
    box = GetStorage();
    position = await determinePosition();
    MyApp.userPosition = position;
    
    DateTime now = DateTime.now();
    currentTimeAmPm = DateFormat().add_jms().format(now);
    currentTimeAmPm = currentTimeAmPm.substring(currentTimeAmPm.length - 2);

    update();
  }

  Future<void> rebuild() async {
    StoriesController storiesController = Get.find();
    RestaurentController restaurentController = Get.find();
    MealsController mealsController = Get.find();
    await restaurentController.getNearest();
    await restaurentController.getResturents();

    await storiesController.getStories();
    await mealsController.getMeals();
  }

  @override
  void onReady() async {
    super.onReady();
    int rndmatch = Random().nextInt(3);
    if (rndmatch == 0 || rndmatch == 1 || rndmatch == 2) {
      Future.delayed(const Duration(seconds: 15))
          .then((value) async => await showCupDialog(rndmatch));
    }
    position = await determinePosition();
    MyApp.userPosition = position;

    if (userController.user != null) {
      print(userController.user!.token);
      int rnd = Random().nextInt(5);

      if (rnd == 1) {
        Future.delayed(const Duration(seconds: 25)).then(
            (va) async => await placesController.showNewPlaceDialog(position!));
      }
    }
    await box.write('position', position);
    await updateFCM();

    await updatePosition();

    await getUserStatus();
    if (Get.parameters['id'] != null) {
      Get.toNamed(AppRoutes.restaurentAds,
          parameters: {'id': Get.parameters['id'].toString()});
    }
    update();
  }

  Future<void> showCupDialog(int rnd) async {
    await Get.defaultDialog(
        title: "",
        titlePadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        titleStyle: AppTextStyles.pinkboldHeading,
        radius: 25,
        content: Column(
          children: [
            const Text(
              "المونديال مع فلاش أوردر غير",
              style: AppTextStyles.pinkboldHeading,
            ),
            if (rnd == 0) const Text("تابع المباريات ونتائجها أولاً بأول"),
            if (rnd == 1) const Text("شجع فريقك المفضل"),
            if (rnd == 2) const Text("توقع واربح الجوائز"),
            const SizedBox(
              height: 20,
            ),
            if (rnd == 0)
              Lottie.asset("assets/images/cupresult.json", width: 150),
            if (rnd == 1)
              Lottie.asset("assets/images/watchcup.json", width: 150),
            if (rnd == 2) Lottie.asset("assets/images/winner.json", width: 150)
          ],
        ));
  }

  Widget buildHello() {
    return currentTimeAmPm != "" && userController.user != null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                currentTimeAmPm == "AM"
                    ? const Icon(Icons.add,
                        color: Color.fromARGB(255, 255, 226, 64))
                    : const Icon(
                        Icons.nightlife,
                        color: Colors.grey,
                      ),
                Text(
                  currentTimeAmPm == "AM"
                      ? "صباح الخير  " +
                          (!userController.user!.name.startsWith("0")
                              ? userController.user!.name
                              : "")
                      : "مساء الخير  " +
                          (!userController.user!.name.startsWith("0")
                              ? userController.user!.name
                              : ""),
                  style: AppTextStyles.greenboldHeading,
                )
              ],
            ),
          )
        : Row();
  }

  Future<void> updateFCM() async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
      var userfcm = fcmController.fcmtoken;
      print("userfcm " + userfcm!);
      await userClient.updateFCM(user.token, userfcm, user.id);
    }
  }

  Future<void> getUserStatus() async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
      var userfcm = fcmController.fcmtoken;
      print("userfcm " + userfcm!);
      var status = await userClient.getStatus(user.token, user.id);
      if (status == "0") {
        Get.offAllNamed(AppRoutes.youarebanded);
      }
    }
  }

  Future<void> updatePosition() async {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
      if (position != null) {
        print(position!.latitude);
        print(position!.longitude);
        await userClient.updatePosition(
            user.token, user.id, position!.latitude, position!.longitude);
      }
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
