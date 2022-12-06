/////////import 'package:cached_network_image/cached_network_image.dart';
/////////import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/DataAccess/Models/captin.dart';
/////////import 'package:flashorder/Presenttion/Widgets/appbar.dart';
/////////import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
/////////import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

/////////import 'package:latlong2/latlong.dart';
import '../../BussinessLogic/Controllers/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key, required this.captin}) : super(key: key);
  final Captin captin;

  @override
  Widget build(BuildContext context) {
    final MapScreenController mapController =
        Get.put(MapScreenController(captin: captin));
    mapController.captinId = captin.id;

    return Row();
    /* SafeArea(
        child: Directionality(
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          body: GetBuilder(
              init: mapController,
              builder: (_) {
                return Container(
                  color: Colors.white,
                  child: Stack(children: [
                    FlutterMap(
                      options: MapOptions(
                        zoom: 13.0,
                        maxZoom: 18,
                        center: LatLng(MyApp.userPosition!.latitude,
                            MyApp.userPosition!.longitude),
                      ),
                      layers: [
                        TileLayerOptions(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 50.0,
                              height: 50.0,
                              point: LatLng(MyApp.userPosition!.latitude,
                                  MyApp.userPosition!.longitude),
                              builder: (ctx) => const SizedBox(
                                child: Icon(
                                  Icons.room,
                                  color: AppColors.pink2,
                                  size: 30,
                                ),
                              ),
                            ),
                            mapController.captinlocation != null
                                ? Marker(
                                    point: mapController.captinlocation!,
                                    builder: (ctx) => SizedBox(
                                        child: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              captin.avatar),
                                    )),
                                  )
                                : Marker(
                                    point: LatLng(mapController.captin.lat,
                                        mapController.captin.lng),
                                    builder: (ctx) => SizedBox(
                                        child: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              captin.avatar),
                                    )),
                                  )
                          ],
                        ),
                      ],
                    ),
                    /* mapController.captinlocation == null
                        ? const Center(child: CircularProgressIndicator())
                        : Row(), */
                  ]),
                );
              })),
    ));
  */
  }
}
