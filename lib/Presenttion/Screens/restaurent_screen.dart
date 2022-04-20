import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurentScreen extends StatelessWidget {
  const RestaurentScreen({Key? key, required this.restaurent})
      : super(key: key);
  final Restaurent restaurent;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(0),
          color: AppColors.lightwhite,
          width: Get.width,
          height: Get.height,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: ListView(children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  ImageHelper.buildImage(restaurent.cover)))),
                    ),
                    Positioned(
                        bottom: 0,
                        left: Get.width / 2 - 55,
                        child: const CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                        )),
                    Positioned(
                        bottom: 5,
                        left: Get.width / 2 - 50,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                              ImageHelper.buildImage(restaurent.logo)),
                        )),
                  ],
                ),
              ),
              Center(
                child: Text(
                  restaurent.name,
                  style: AppTextStyles.greyboldHeading,
                ),
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
