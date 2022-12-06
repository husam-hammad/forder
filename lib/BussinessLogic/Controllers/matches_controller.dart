import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/match.dart';
import 'package:flashorder/DataAccess/Models/restaurent.dart';
import 'package:flashorder/DataAccess/Repository/matches_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';

class MatchesController extends GetxController {
  MatchesRepo repo = MatchesRepo();
  final RestaurentController restaurentController = Get.find();
  List<Match> matches = [];
  List<Match> todayMatches = [];
  List<Match> tomorrowMatches = [];

  List<Restaurent> restaurents = [];

  TextEditingController personsEditing = TextEditingController();
  var isloading = false.obs;
  var acceptSending = false.obs;
  var sending = false.obs;
  @override
  void onInit() async {
    isloading.value = true;
    update();
    load();
    isloading.value = false;
    update();
    super.onInit();
  }

  Future<void> load() async {
    restaurents = restaurentController.restaurents
        .where((element) => element.worldcup == 1)
        .toList();
    matches = await repo.getMatches();
    update();
    todayMatches = matches.where((element) => element.today == 1).toList();
    update();
    tomorrowMatches =
        matches.where((element) => element.tomorrow == 1).toList();
    update();
  }

  void showTableDialog(restaurnetName, restaurentId) async {
    await Get.bottomSheet(Container(
      height: 250,
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: CustomStyles.raduis100),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "لتأكيد الحجز في مطعم $restaurnetName يرجى إدخال عدد الأشخاص المطلوب :  ",
            style: AppTextStyles.greenBoldTitle,
            textAlign: TextAlign.center,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: personsEditing,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: CustomStyles.pinkBorder,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 5)),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: CustomStyles.acceptButtonStyle2,
                onPressed: () async {
                  await sendTableRequest(restaurentId);
                },
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (sending.value == true)
                        const CircularProgressIndicator(),
                      if (sending.value == true)
                        const SizedBox(
                          width: 10,
                        ),
                      const Text(
                        "تأكيد",
                        style: AppTextStyles.whiteRegularHeading,
                      ),
                    ],
                  );
                })),
          )
        ],
      ),
    ));
  }

  Future<void> sendTableRequest(restaurentId) async {
    sending.value = true;
    update();
    if (personsEditing.value.text != "" && personsEditing.value.text != "0") {
      if (await repo.sendTableRequest(
              restaurentId, personsEditing.value.text) ==
          true) {
        Get.back();
        Get.rawSnackbar(
          duration: const Duration(seconds: 1),
          messageText: const Text(
            "تم الحجز بنجاح",
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: AppColors.green,
        );
      } else {
        Get.back();
        Get.rawSnackbar(
          duration: const Duration(seconds: 1),
          messageText: const Text(
            "حدث خطأ ما , يرجى التأكد من اتصالك بالانترنت",
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: Colors.redAccent,
        );
      }
    } else {
      Get.back();
      Get.rawSnackbar(
        duration: const Duration(seconds: 1),
        messageText: const Text(
          "يرجى تحديد عدد الأشخاص ",
          textAlign: TextAlign.center,
          style: AppTextStyles.whiteRegularHeading,
        ),
        backgroundColor: Colors.redAccent,
      );
    }
    sending.value = false;
    update();
  }
}
