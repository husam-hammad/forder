import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/Presenttion/Widgets/custom_bottom.dart';
import 'package:flashorder/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlacesScreen extends StatelessWidget {
  PlacesScreen({Key? key}) : super(key: key);
  final PlacesController placesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            placesController.showNewPlaceDialog(MyApp.userPosition!);
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: CustomBotttomNav(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "الأماكن المثبتة ",
                    style: AppTextStyles.pinkboldTopPage,
                  ),
                  /* InkWell(
                          onTap: () async {
                            /* await cartController.deleteAll(); */
                          },
                          child: const Text(
                            "عرض الكل",
                            style: AppTextStyles.greyregular,
                          ),
                        ) */
                ],
              ),
            ),
            SizedBox(
              height: Get.height - 250,
              width: double.infinity,
              child: GetBuilder(
                  init: placesController,
                  builder: (_) {
                    // ignore: avoid_print
                    print(placesController.places);
                    return ListView.builder(
                      itemCount: placesController.places.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(placesController.places[index].name),
                          leading: const Icon(
                            Icons.room,
                            color: AppColors.pink,
                          ),
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
