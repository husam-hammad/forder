import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  var box = GetStorage();
  User? user;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController birthdaycontroller = TextEditingController();
  String points = "0";
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() {
    if (box.read('userdata') != null) {
      user = User.fromMap(box.read('userdata'));
    }
    if (user != null) {
      namecontroller.text = user!.phone.toString();
      phonecontroller.text = user!.phone.toString();
      birthdaycontroller.text = user!.birthday.toString();
      points = user!.points.toString();
    }
  }

  void saveData() {
    Get.rawSnackbar(
      duration: const Duration(seconds: 1),
      messageText: const Text(
        "تم الحفظ بنجاح",
        textAlign: TextAlign.center,
        style: AppTextStyles.whiteRegularHeading,
      ),
      backgroundColor: AppColors.green,
    );
  }
}
