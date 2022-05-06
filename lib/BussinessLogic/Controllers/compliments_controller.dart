import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/complimnet_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/compliments.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/DataAccess/Repository/compliment_repo.dart';
/* import 'package:flashorder/DataAccess/Models/restaurent.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ComplimentController extends GetxController {
  final RestaurentController restaurentController = Get.find();
  TextEditingController description = TextEditingController();
  late ComplimentRepo complimentRepo;
  int? restaurentId;
  late User? user;
  var box = GetStorage();
  void showAdd() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "نص الشكوى | الإقتراح",
                textAlign: TextAlign.center,
                style: AppTextStyles.greenboldHeading,
              ),
              const Divider(),
              TextField(
                controller: description,
                autofocus: true,
                textAlign: TextAlign.right,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: ElevatedButton(
                    style: CustomStyles.acceptButtonStyle,
                    onPressed: () async {
                      complimentRepo = ComplimentRepo(ComplimentClient());
                      if (box.read('userdata') != null) {
                        user = User.fromMap(box.read('userdata'));
                      }
                      Compliment compliment = Compliment(
                          id: 0,
                          userId: user!.id,
                          description: description.text,
                          reply: null,
                          createdAt: null,
                          repliedAt: null,
                          restaurentId: restaurentId);
                      if (user != null) {
                        String token = user!.token;

                        if (await complimentRepo.sendCompliment(
                            compliment.toJson(), token)) {
                          Get.back();
                          Get.rawSnackbar(
                            duration: const Duration(seconds: 1),
                            messageText: const Text(
                              "تم الإرسال  بنجاح",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.whiteRegularHeading,
                            ),
                            backgroundColor: AppColors.green,
                          );
                        }
                      }
                    },
                    child: const Text(
                      "إرسال",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.whiteRegularDetail,
                    )),
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.lightwhite,
      isDismissible: true,
      shape: const RoundedRectangleBorder(borderRadius: CustomStyles.raduis100),
      isScrollControlled: true,
    );
  }
}
