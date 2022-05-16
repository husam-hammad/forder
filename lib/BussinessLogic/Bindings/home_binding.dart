import 'package:flashorder/BussinessLogic/Controllers/cart_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/favorite_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/home_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/meals_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/restaurent_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/setting_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/stories_controller.dart';
import 'package:flashorder/BussinessLogic/Controllers/user_contoller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RestaurentController>(() => RestaurentController());
    Get.lazyPut<MealsController>(() => MealsController());
    Get.lazyPut<StoriesController>(() => StoriesController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.put<OrderController>(OrderController());
    Get.put<CartController>(CartController());
    Get.put<UserController>(UserController());
  }
}
