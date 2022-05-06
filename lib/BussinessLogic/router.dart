import 'package:flashorder/BussinessLogic/Bindings/home_binding.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Presenttion/Screens/Auth/profile.dart';
import 'package:flashorder/Presenttion/Screens/cart_screen.dart';
import 'package:flashorder/Presenttion/Screens/compliments_screen.dart';
import 'package:flashorder/Presenttion/Screens/favorites_screen.dart';
import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/meals_screen.dart';
import 'package:flashorder/Presenttion/Screens/notifications_screen.dart';
import 'package:flashorder/Presenttion/Screens/orders_screen.dart';
import 'package:flashorder/Presenttion/Screens/restaurents_screen.dart';
import 'package:flashorder/Presenttion/Screens/search_screen.dart';
//import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/splash_screen.dart';
/* import 'package:flashorder/Presenttion/Screens/splash_screen.dart'; */
import 'package:get/get.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: AppRoutes.favorites, page: () => FavoritesScreen()),
  GetPage(name: AppRoutes.notifications, page: () => NotificationScreen()),
  GetPage(
      name: AppRoutes.homepage,
      page: () => HomeScreen(),
      binding: HomeBinding()),
  GetPage(name: AppRoutes.usercarts, page: () => UserCart()),
  GetPage(name: AppRoutes.compliments, page: () => ComplimentScreen()),
  GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
  GetPage(name: AppRoutes.meals, page: () => MealsScreen()),
  GetPage(name: AppRoutes.restaurents, page: () => RestaurentsScreen()),
  GetPage(name: AppRoutes.search, page: () => SearchScreen()),
  GetPage(name: AppRoutes.orders, page: () => OrdersScreen()),
];
