import 'package:flashorder/BussinessLogic/Bindings/home_binding.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Presenttion/Screens/cart_screen.dart';
import 'package:flashorder/Presenttion/Screens/favorites_screen.dart';
import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/notifications_screen.dart';
//import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/splash_screen.dart';
/* import 'package:flashorder/Presenttion/Screens/splash_screen.dart'; */
import 'package:get/get.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: AppRoutes.favorites, page: () => FavoritesScreen()),
  GetPage(
      name: AppRoutes.notifications, page: () => const NotificationScreen()),
  GetPage(
      name: AppRoutes.homepage,
      page: () => HomeScreen(),
      binding: HomeBinding()),
  GetPage(name: AppRoutes.usercarts, page: () => UserCart())
];
