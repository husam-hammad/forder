import 'package:flashorder/BussinessLogic/Controllers/advertise_controller.dart';
import 'package:get/get.dart';

class AdvertiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdvertiseController>(AdvertiseController());
  }
}
