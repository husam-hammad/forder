// ignore_for_file: avoid_print

import 'package:flashorder/BussinessLogic/Providers/order_client.dart';
import 'package:flashorder/DataAccess/Models/user_order.dart';
import 'package:flashorder/DataAccess/Repository/orders_repo.dart';
import 'package:flashorder/Presenttion/Screens/order_screen.dart';
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
    print(orders);
  }

  void gotoOrder(orderId) {
    UserOrder order =
        orders.where((element) => element.id == orderId).toList()[0];
    Get.to(OrderScreen(
      order: order,
    ));
  }
}
