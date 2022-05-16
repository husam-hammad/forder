import 'package:flashorder/BussinessLogic/Controllers/orders_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
// ignore: prefer_final_fields
  static AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails("0", "main Channel",
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          enableLights: true);

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: _androidNotificationDetails);
  factory NotificationService() {
    return _notificationService;
  }
  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    bool checkOrderController = Get.isRegistered<OrderController>();
    if (!checkOrderController) {
      Get.put(OrderController());
    }

    Get.toNamed(payload!);
  }

  Future<void> showNotifications(title, body, payload) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload ?? "/homepage",
    );
  }

  NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
}
