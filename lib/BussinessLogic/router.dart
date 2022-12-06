import 'package:flashorder/BussinessLogic/Bindings/advertise_binding.dart';
import 'package:flashorder/BussinessLogic/Bindings/home_binding.dart';
import 'package:flashorder/BussinessLogic/Bindings/init_binding.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Presenttion/Ads/ads_restaurent_screen.dart';
import 'package:flashorder/Presenttion/Screens/Auth/login.dart';
import 'package:flashorder/Presenttion/Screens/Auth/profile.dart';
import 'package:flashorder/Presenttion/Screens/app_version.dart';
import 'package:flashorder/Presenttion/Screens/cart_screen.dart';
import 'package:flashorder/Presenttion/Screens/compliments_screen.dart';
import 'package:flashorder/Presenttion/Screens/contactus.dart';
import 'package:flashorder/Presenttion/Screens/favorites_screen.dart';
import 'package:flashorder/Presenttion/Screens/googlemap_screen.dart';
import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/mandatory_update.dart';
import 'package:flashorder/Presenttion/Screens/meals_screen.dart';
import 'package:flashorder/Presenttion/Screens/notifications_screen.dart';
import 'package:flashorder/Presenttion/Screens/order_screen.dart';
import 'package:flashorder/Presenttion/Screens/orders_screen.dart';
import 'package:flashorder/Presenttion/Screens/places_screen.dart';
import 'package:flashorder/Presenttion/Screens/qatar_cup/matches_today.dart';
import 'package:flashorder/Presenttion/Screens/qatar_cup/tomorwo_matches.dart';
import 'package:flashorder/Presenttion/Screens/qatar_cup/world_cup.dart';
import 'package:flashorder/Presenttion/Screens/rating_screen.dart';
import 'package:flashorder/Presenttion/Screens/restaurents_screen.dart';
import 'package:flashorder/Presenttion/Screens/search_screen.dart';
//import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flashorder/Presenttion/Screens/splash_screen.dart';
import 'package:flashorder/Presenttion/Widgets/noconnection.dart';
/* import 'package:flashorder/Presenttion/Screens/splash_screen.dart'; */
import 'package:get/get.dart';

import '../Presenttion/Screens/qatar_cup/worldcup_restaurents.dart';
import '../Presenttion/Screens/youarebanded.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(name: AppRoutes.favorites, page: () => FavoritesScreen()),
  GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationScreen(),
      transition: Transition.circularReveal),
  GetPage(
      name: AppRoutes.homepage,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.leftToRightWithFade),
  GetPage(
      name: AppRoutes.ads,
      page: () => HomeScreen(),
      binding: AdvertiseBinding()),
  GetPage(
      name: AppRoutes.restaurentAds,
      page: () => AdsRestaurentScreen(),
      binding: InitBinding()),
  GetPage(name: AppRoutes.ratingscreen, page: () => RatingScreen()),
  GetPage(
      name: AppRoutes.usercarts,
      page: () => UserCart(),
      transition: Transition.size),
  GetPage(
      name: AppRoutes.compliments,
      page: () => ComplimentScreen(),
      transition: Transition.leftToRight),
  GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      transition: Transition.circularReveal),
  GetPage(
      name: AppRoutes.meals,
      page: () => MealsScreen(),
      transition: Transition.zoom),
  GetPage(
      name: AppRoutes.restaurents,
      page: () => RestaurentsScreen(),
      transition: Transition.size),
  GetPage(
      name: AppRoutes.search,
      page: () => SearchScreen(),
      transition: Transition.downToUp),
  GetPage(
      name: AppRoutes.orders,
      page: () => OrdersScreen(),
      transition: Transition.leftToRight),
  GetPage(name: AppRoutes.login, page: () => Login()),
  GetPage(
      name: AppRoutes.order,
      page: () => OrderScreen(),
      transition: Transition.leftToRight),
  GetPage(name: AppRoutes.contactus, page: () => const ContactUs()),
  GetPage(
      name: AppRoutes.places,
      page: () => PlacesScreen(),
      transition: Transition.downToUp),
  GetPage(
      name: AppRoutes.notconnected,
      page: () => const NoConnection(),
      transition: Transition.fadeIn),
  GetPage(name: AppRoutes.pleaseupdate, page: () => const MandatoryUpdate()),
  GetPage(name: AppRoutes.youarebanded, page: () => const YouAreBanded()),
  GetPage(name: AppRoutes.appversion, page: () => AppVersion()),
  GetPage(name: AppRoutes.worldcup, page: () => WorldCup()),
  GetPage(name: AppRoutes.matches, page: () => TodayMatches()),
  GetPage(name: AppRoutes.tomorrowmatches, page: () => TomorrowMatches()),
  GetPage(
      name: AppRoutes.worldcuprestaurents, page: () => WorldCupRestaunrets()),
GetPage(
      name: AppRoutes.mapscreen, page: () => GoogleMapsScreen()),



      
];
