// ignore_for_file: avoid_print

import 'package:flashorder/DataAccess/Models/user.dart';
import 'package:get_storage/get_storage.dart';

class BoxProvider {
  static Future<User?> getuser() async {
    var box = GetStorage();
    if (await box.read('userdata') != null) {
      print(box.read('userdata'));
      return User.fromMap(box.read('userdata'));
    } else {
      return null;
    }
  }
}
