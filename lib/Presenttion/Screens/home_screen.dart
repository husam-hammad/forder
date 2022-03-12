import 'package:flashorder/BussinessLogic/Controllers/first_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: prefer_const_constructors
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GetBuilder<FirstContoller>(
        init: FirstContoller(),
        builder: (value) => Text("${value.count}"),
      )),
    );
  }
}
