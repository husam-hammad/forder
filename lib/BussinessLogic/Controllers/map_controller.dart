/* import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapController extends GetxController {
  HomeController homeController = Get.find();
  late CameraPosition initialCameraPosition;
  late MapboxMapController controller;

  @override
  void onInit() {
    super.onInit();
    initialCameraPosition = CameraPosition(
        target: LatLng(
            homeController.position.latitude, homeController.position.altitude),
        zoom: 15);
  }

  onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }
}
 */