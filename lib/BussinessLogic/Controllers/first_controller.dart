import 'package:get/get.dart';

class FirstContoller extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update();
  }
}
