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
  void onInit() async {
    super.onInit();
    placesRepo = PlacesRepo(PlaceClient());
    await getAll();
  }

  Future<void> getAll() async {
    places = await placesRepo.getAll();
    print(places);
    update();
  }

  Future<void> showNewPlaceDialog(Position position) async {
    await Get.defaultDialog(
        title: "هل تريد إضافة الموقع الحالي إلى الأماكن المثبتة",
        titlePadding: const EdgeInsets.all(25),
        titleStyle: AppTextStyles.pinkboldHeading,
        radius: 25,
        content: Column(
          children: [
            TextField(
              controller: placename,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "اسم المكان ",
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
            TextField(
              controller: placeadress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "العنوان ",
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
            child: const Text(
              "إضافة",
              style: AppTextStyles.whiteRegularHeading,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.green,
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
                Get.back();
              }
            }),
        cancel: ElevatedButton(
            child: const Text("تخطي"),
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.grey,
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
