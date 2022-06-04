// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/BussinessLogic/Providers/notification_client.dart';
import 'package:flashorder/DataAccess/Models/back_notification.dart';
import 'package:flashorder/DataAccess/Repository/notification_repo.dart';
import 'package:get/get.dart';

class NotificationContoller extends GetxController {
  List<BackNotification> notifications = [];
  late NotificationRepo notificationRepo;
  bool endloading = false;
  late OrderController orderController;
  @override
  void onInit() async {
    super.onInit();
    print("start init notificaipn");
    getAll();
    orderController = await Get.put(OrderController());
    await orderController.getAll();
  }

  void gotopage(name) {
    if (name != "") {
      Get.toNamed(name);
    }
  }

  Future<void> getAll() async {
    notificationRepo = NotificationRepo(NotificationClient());
    notifications = await notificationRepo.getall();
    endloading = true;
    update();
  }
}
