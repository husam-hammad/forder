// ignore_for_file: avoid_print

import 'package:custom_marker/marker_icon.dart';
import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/DataAccess/Models/captin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
//import '../Providers/user_client.dart';

class MapScreenController extends GetxController {
  HomeController homeController = Get.find();
  int? captinId;
  late LatLng? captinlocation;
  Captin captin;
  late http.Response response;
  MapScreenController({
    required this.captin,
  });

  void updateCaptinLocation(lat, long) async {
    print("Update Captin Location");
    captinlocation = LatLng(lat, long);
    update();
    if (captinlocation != null) {
      print("captinlocation NOT NULL");
      if (markers.contains(Marker(markerId: MarkerId(captin.id.toString())))) {
        markers.removeWhere(
          (element) => element.markerId == MarkerId(captin.id.toString()),
        );
      }

      final marker = Marker(
        markerId: const MarkerId("captin_id"),
        position: captinlocation!,
        icon: await MarkerIcon.downloadResizePictureCircle(captin.avatar),
        infoWindow: InfoWindow(
          title: captin.name,
        ),
        //icon:
      );

      markers.add(marker);
      update();
      try {
        await mapController!.showMarkerInfoWindow(const MarkerId("captin_id"));
        await mapController!
            .moveCamera(CameraUpdate.newLatLng(captinlocation!));
      } catch (e) {
        print(e);
      }
      update();
    }
  }

  @override
  void onClose() async {
    UserClient userClient = UserClient();
    await userClient.stopSendLocation("", captinId, 0);
    super.onClose();
  }

  GoogleMapController? mapController;

  LatLng? center;
  LatLng damascus = const LatLng(33.5138062, 36.2765261);
  Marker? currentLocation;
  LatLng? selectedLatLng;
  Marker? selectedMarker;
  var saving = false.obs;
  final Set<Marker> markers = {};
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    update();
  }

  @override
  void onInit() async {
    response = await http.get(Uri.parse(captin.avatar));

    Position position = await Geolocator.getCurrentPosition();
    captinlocation = null;
    center = LatLng(double.parse(position.latitude.toString()),
        double.parse(position.longitude.toString()));
    update();
    if (center != null) {
      print("center not null");
      final marker = Marker(
        markerId: const MarkerId("1"),
        position: center!,
        infoWindow: const InfoWindow(
          title: "موقعك الحالي",
        ),
        //icon:
      );
      final marker2 = Marker(
        markerId: const MarkerId("captin_id"),
        position: LatLng(captin.lat, captin.lng),
        icon: await MarkerIcon.downloadResizePictureCircle(captin.avatar),
        infoWindow: InfoWindow(
          title: captin.name,
        ),
        //icon:
      );
      markers.add(marker);
      markers.add(marker2);
      update();
      try {
        await mapController!.showMarkerInfoWindow(const MarkerId("1"));
      } catch (e) {
        print(e);
      }
      update();
    } else {
      print("center null");
    }
    super.onInit();
  }

  @override
  void onReady() {
    update();
    super.onReady();
  }
}
