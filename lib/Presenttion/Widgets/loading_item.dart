import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget loadingItem() {
  return LottieBuilder.asset(
    'assets/images/loading.json',
    width: 30,
  );
}

Widget loadingItemGreen() {
  return LottieBuilder.asset(
    'assets/images/loading-green.json',
    width: 75,
  );
}
