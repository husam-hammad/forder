import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../BussinessLogic/Controllers/map_controller.dart';

class GoogleMapsScreen extends StatelessWidget {
  GoogleMapsScreen({Key? key}) : super(key: key);

  final MapScreenController controller =
      Get.put(MapScreenController(captin: Get.arguments[0]));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: const CustomBotttomNav(),
        body: GetBuilder(
            init: controller,
            builder: (context) {
              return SizedBox(
                height: double.infinity,
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  trafficEnabled: true,
                  onMapCreated: controller.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: controller.center ?? controller.damascus,
                    zoom: 11.0,
                  ),
                  markers: controller.markers,
                ),
              );
            }),
      ),
    ));
  }
}
