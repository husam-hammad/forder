// ignore_for_file: avoid_print

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class NavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  int selectedindex = 0;
  @override
  void onInit() async {
    super.onInit();
    animationController = AnimationController(vsync: this);
  }

  void changeIndex(index) {
    selectedindex = index;
    update();
  }

  Future<void> animateNotification() async {
    print("start animateNotification");
    await animationController.forward();
    animationController.reset();
  }
}
