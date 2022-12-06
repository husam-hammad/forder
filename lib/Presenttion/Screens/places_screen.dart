import 'package:flashorder/BussinessLogic/Controllers/places_contoller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
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
      textDirection: Get.locale!.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: buildAppBar(),
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            placesController.showNewPlaceDialog(MyApp.userPosition!);
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "pinnedplaces".tr,
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
                      return ListView.builder(
                        itemCount: placesController.places.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              style: ListTileStyle.drawer,
                              title: Text(placesController.places[index].name,
                                  style: AppTextStyles.greenboldHeading),
                              subtitle: Text(
                                placesController.places[index].adress,
                                style: AppTextStyles.greyregular,
                              ),
                              leading: const Icon(
                                Icons.room,
                                color: AppColors.pink,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  placesController.delete(
                                      placesController.places[index].id);
                                },
                                icon: const Icon(Icons.delete),
                              ));
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
