import 'package:flashorder/BussinessLogic/Bindings/home_binding.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Presenttion/Screens/favorites_screen.dart';
import 'package:flashorder/Presenttion/Screens/home_screen.dart';
//import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/splash_screen.dart';
/* import 'package:flashorder/Presenttion/Screens/splash_screen.dart'; */
import 'package:get/get.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: '/favorites', page: () => FavoritesScreen()),
  GetPage(
      name: AppRoutes.homepage,
      page: () => HomeScreen(),
      binding: HomeBinding()),
];
