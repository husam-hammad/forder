// ignore_for_file: await_only_futures, avoid_print

import 'package:flashorder/BussinessLogic/Providers/box_provider.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' as ints;

class UserController extends GetxController {
  var box = GetStorage();
  User? user;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController birthdaycontroller = TextEditingController();
  String points = "0";
  DateTime? selected;
  UserClient userClient = UserClient();
  var saving = false.obs;
  final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd');
  @override
  void onInit() async {
    super.onInit();
    await getUser();
  }

  Future<void> getUser() async {
    User? user = await BoxProvider.getuser();
    if (user != null) {
      namecontroller.text = user.name.toString();
      phonecontroller.text = user.phone.toString();
      if (user.birthday != null) {
        birthdaycontroller.text = formatter.format(user.birthday!);
      }

      points = user.points.toString();
    }
    update();
  }

  void saveData() async {
    saving.value = true;
    User? user = await BoxProvider.getuser();
    if (user != null) {
      User? newdata = await userClient.updateUserInfo(user.token, user.id,
          namecontroller.text, phonecontroller.text, birthdaycontroller.text);
      if (newdata != null) {
        //await box.remove('userdata');
        await box.write('userdata', newdata.toBoxMap());
        await getUser();
        Get.rawSnackbar(
          duration: const Duration(seconds: 1),
          messageText: const Text(
            "تم الحفظ بنجاح",
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: AppColors.green,
        );
      } else {
        saving.value = false;
        Get.rawSnackbar(
          duration: const Duration(seconds: 1),
          messageText: const Text(
            "خطأ أثناء الحفظ",
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: Colors.red,
        );
      }
      saving.value = false;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selected ?? DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selected) {
      selected = picked;
      birthdaycontroller.text = formatter.format(picked);
    }
  }
}
