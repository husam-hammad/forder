// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/notification_client.dart';
import 'package:flashorder/DataAccess/Models/back_notification.dart';
import 'package:flashorder/DataAccess/Repository/notification_repo.dart';
import 'package:get/get.dart';

class NotificationContoller extends GetxController {
  List<BackNotification> notifications = [];
  late NotificationRepo notificationRepo;
  @override
  void onInit() {
    super.onInit();
    getAll();
  }

  Future<void> getAll() async {
    notificationRepo = NotificationRepo(NotificationClient());
    notifications = await notificationRepo.getall();
    update();
    print(notifications);
  }
}
