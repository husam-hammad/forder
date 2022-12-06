import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  late VoidCallback action;
  Timer? timer;

  Debouncer();

  run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: 500), action);
  }
}
