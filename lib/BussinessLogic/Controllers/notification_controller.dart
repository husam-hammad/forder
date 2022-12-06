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
  var showgetmore = false.obs;

  int page = 1;
  @override
  void onInit() async {
    super.onInit();
    getAll(true);
    orderController = await Get.put(OrderController());
    await orderController.getAll();
  }

  void gotopage(name) {
    if (name != "") {
      Get.toNamed(name);
    }
  }

  Future<void> getAll(bool refresh) async {
    print('start get new');
    if (page > 1) {
      showgetmore = true.obs;
    }
    notificationRepo = NotificationRepo(NotificationClient());
    if (refresh) {
      var newNoties = await notificationRepo.getall(1);
      notifications = newNoties;
    } else {
      var newNoties = await notificationRepo.getall(page);
      notifications.addAll(newNoties);
    }

    endloading = true;
    page++;
    showgetmore = false.obs;
    update();
  }
}
