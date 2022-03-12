import 'package:flashorder/Presenttion/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetxFire.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlashOrder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
