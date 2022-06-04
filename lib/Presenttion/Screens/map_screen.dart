import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/DataAccess/Models/captin.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key, required this.captin}) : super(key: key);
  final Captin captin;
  /* final MapController mapController = Get.put(MapController()); */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: buildAppBar(),
          body: Container(
            color: Colors.white,
            child: FlutterMap(
              options: MapOptions(
                zoom: 13.0,
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
                    Marker(
                      point: LatLng(MyApp.userPosition!.latitude + 0.005,
                          MyApp.userPosition!.longitude + 0.005),
                      builder: (ctx) => SizedBox(
                          child: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(captin.avatar),
                      )),
                    )
                  ],
                ),
              ],
            ),
          )),
    ));
  }
}
