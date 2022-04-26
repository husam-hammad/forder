import 'package:flashorder/Constants/colors.dart';
import 'package:flutter/material.dart';

class CustomStyles {
  static const raduis50 = BorderRadius.all(Radius.circular(10));
  static const raduis100 = BorderRadius.all(Radius.circular(20));
  static ButtonStyle acceptButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(10),
    shape: const RoundedRectangleBorder(borderRadius: CustomStyles.raduis100),
    primary: AppColors.green,
  );
}
