import 'package:flashorder/Presenttion/Widgets/appbar.dart';
import 'package:flutter/material.dart';

class UserCart extends StatelessWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(),
        body: Column(),
      ),
    ));
  }
}
