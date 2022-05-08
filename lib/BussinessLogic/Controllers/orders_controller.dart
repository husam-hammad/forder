// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/order_client.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';
import 'package:flashorder/DataAccess/Repository/orders_repo.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  late List<UserOrder> orders = [];
  late OrderRepo orderRepo;
  bool ordersLoaded = false;
  @override
  void onInit() async {
    super.onInit();
    await getAll();
  }

  Future<void> getAll() async {
    orderRepo = OrderRepo(OrderClient());
    orders = await orderRepo.getall();
    ordersLoaded = true;
    update();
  }

  void gotoOrder(orderId) {
    try {
      Get.toNamed(AppRoutes.order, parameters: {'order': orderId});
    } catch (e) {
      print(e);
    }
  }

  UserOrder userOrderFormID(id) {
    return orders.where((element) => element.id == id).first;
  }
}
