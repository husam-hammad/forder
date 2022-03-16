import 'package:get/get.dart';

class FirstContoller extends GetxController {
  var count = 10.obs;

  void increment() {
    count++;
  }
}
