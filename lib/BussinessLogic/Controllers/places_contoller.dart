// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/place_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/place.dart';
import 'package:flashorder/DataAccess/Repository/places_repo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PlacesController extends GetxController {
  late List<Place> places = [];
  late PlacesRepo placesRepo;
  TextEditingController placename = TextEditingController();
  TextEditingController placeadress = TextEditingController();

  @override
  void onReady() async {
    placesRepo = PlacesRepo(PlaceClient());
    await getAll();
  }

  Future<void> getAll() async {
    places = await placesRepo.getAll();
    update();
  }

  Future<void> delete(id) async {
    await placesRepo.delete(id);
    await getAll();
  }

  Future<void> showNewPlaceDialog(Position position) async {
    await Get.defaultDialog(
        title: "addcurrentlocation".tr,
        titlePadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        titleStyle: AppTextStyles.pinkboldHeading,
        radius: 25,
        content: Column(
          children: [
            TextField(
              controller: placename,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "palcename".tr,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.pink,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: AppColors.lightgrey, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: placeadress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "adress".tr,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.pink,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: AppColors.lightgrey, width: 2.0),
                ),
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(25),
        confirm: ElevatedButton(
            child: Text(
              "add".tr,
              style: AppTextStyles.whiteRegularHeading,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            onPressed: () async {
              if (placename.text != '') {
                await placesRepo.addPlace(Place(
                    id: 0,
                    name: placename.text,
                    adress: placeadress.text,
                    lat: position.latitude,
                    long: position.longitude));
                await getAll();
                placename.text = "";
                placeadress.text = "";
                Get.back();
              }
            }),
        cancel: ElevatedButton(
            child: Text('skip'.tr, style: AppTextStyles.whiteRegularHeading),
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.grey,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            )),
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          if (placename.text != '') {
            placesRepo.addPlace(Place(
                id: 0,
                name: placename.text,
                adress: placeadress.text,
                lat: position.latitude,
                long: position.longitude));
            Get.back();
          } else {}
        });
  }
}
