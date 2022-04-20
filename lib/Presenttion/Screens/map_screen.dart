import 'package:flashorder/BussinessLogic/Controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: MapboxMap(
              initialCameraPosition: mapController.initialCameraPosition),
        ),
      ),
    ));
  }
}
