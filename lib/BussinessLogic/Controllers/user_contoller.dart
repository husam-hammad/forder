// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashorder/BussinessLogic/Providers/box_provider.dart';
import 'package:flashorder/BussinessLogic/Providers/user_client.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/custom_styles.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:flashorder/Presenttion/Themes/themes.dart';
import 'package:flashorder/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' as ints;
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  var box = GetStorage();
  User? user;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController birthdaycontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  var points = "0".obs;
  DateTime? selected;
  UserClient userClient = UserClient();
  var saving = false.obs;
  final ints.DateFormat formatter = ints.DateFormat('yyyy-MM-dd');
  File? image;
  final picker = ImagePicker();
  @override
  void onInit() async {
    super.onInit();

    await getUser();
    await getPoints();
  }

  Future<void> changetheme() async {
    Get.defaultDialog(
        title: "",
        contentPadding: const EdgeInsets.all(10),
        content: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: Text("lightmode".tr),
              onTap: () async {
                await box.write('theme', "light");
                Get.changeTheme(Themes.lightTheme);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: Text("darkmode".tr),
              onTap: () async {
                await box.write('theme', "dark");
                Get.changeTheme(Themes.darkTheme);
                Get.back();
              },
            )
          ],
        ));
  }

  Future<void> changeLang(Locale local) async {
    await Get.updateLocale(local);
    await box.write("lang", local.languageCode);
    AppTextStyles.family =
        Get.locale?.languageCode == "en" ? "Montserrat" : "Cairo";
    Get.toNamed(AppRoutes.homepage);
  }

  void showImage(image) {
    if (image != "" && image != 'users/default.png') {
      Get.dialog(Container(
        width: Get.width - 100,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: CustomStyles.raduis100,
            image: DecorationImage(
                image: CachedNetworkImageProvider(buildUserAvatar(image)))),
      ));
    }
  }

  void imageOptions(String? image) {
    Get.bottomSheet(
        SizedBox(
          height: 200,
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  "عرض الصورة",
                  textAlign: TextAlign.right,
                ),
                onTap: () {
                  Get.back();
                  showImage(image);
                },
              ),
              ListTile(
                title: const Text("اختيار صورة", textAlign: TextAlign.right),
                onTap: () async {
                  await getImage();
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shape:
            const RoundedRectangleBorder(borderRadius: CustomStyles.raduis100));
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      /* user!.avatar = image!.path; */
      await uploadImage(image!.path);
      update();
    } else {
      print('No image selected.');
    }
  }

  Future<void> getUser() async {
    User? _user = await BoxProvider.getuser();
    user = _user;
    if (user != null) {
      namecontroller.text = user!.name.toString();
      phonecontroller.text = user!.phone.toString();
      adresscontroller.text = user!.adress.toString();
      var getpoints = await userClient.getUserPoint(user!.token, user!.id);
      points.value = (getpoints.toString() != "" && getpoints != "0")
          ? getpoints.toString()
          : user!.points.toString();
      if (user!.birthday != null) {
        birthdaycontroller.text = formatter.format(user!.birthday!);
      }
    } else {
      print("no data set");
    }

    update();
  }

  Future<void> getPoints() async {
    User? user = await BoxProvider.getuser();

    if (user != null) {
      var getpoints = await userClient.getUserPoint(user.token, user.id);

      points.value = (getpoints.toString() != "" && getpoints != "0")
          ? getpoints.toString()
          : user.points.toString();
    }
  }

  String buildUserAvatar(image) {
    String newImage =
        ImageHelper.buildImage('http://theflashorder.sy/storage/' + image);
    return newImage;
  }

  Future<void> uploadImage(image) async {
    saving.value = true;
    User? user = await BoxProvider.getuser();
    if (user != null) {
      User? newdata =
          await userClient.updateUserImage(user.token, user.id, image);
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
          messageText: Text(
            "errorinsend".tr,
            textAlign: TextAlign.center,
            style: AppTextStyles.whiteRegularHeading,
          ),
          backgroundColor: Colors.red,
        );
      }
      saving.value = false;
    }
  }

  /* Future<bool> sendOrderRating(
      orderid, restauretId, captinId, restaurentRating, captinRating) async {
    User? user = await BoxProvider.getuser();
    if (user != null) {
      if (await userClient.sendOrderRating(user.token, orderid, user.id,
              restauretId, restaurentRating, captinId, captinRating) ==
          200) {
        return true;
      }
    }
    return false;
  } */

  void saveData() async {
    saving.value = true;
    User? user = await BoxProvider.getuser();
    if (user != null) {
      User? newdata = await userClient.updateUserInfo(
        user.token,
        user.id,
        namecontroller.text,
        phonecontroller.text,
        birthdaycontroller.text,
        adresscontroller.text,
      );
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

  Future<void> logout() async {
    await box.remove('userdata');
    await box.remove('authed');
    user = null;
    update();
    Get.toNamed(AppRoutes.login);
  }

  void showContactus() {
    Get.toNamed(AppRoutes.contactus);
  }
}
