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
  void onReady() async {
    super.onReady();
    await getAll();
  }

/*   @override
  void onInit() async {
    super.onInit();

  } */
  void rebluid() {
    try {} catch (e) {
      print(e);
    }
  }

  Future<void> getAll() async {
    orderRepo = OrderRepo(OrderClient());
    orders = await orderRepo.getall();

    ordersLoaded = true;
    update();
  }

  void gotoOrder(orderId) {
    Get.toNamed(AppRoutes.order, parameters: {'order': orderId.toString()});
    try {} catch (e) {
      print(e);
    }
  }

  UserOrder userOrderFormID(id) {
    return orders.where((element) => element.id == id).first;
  }
}
