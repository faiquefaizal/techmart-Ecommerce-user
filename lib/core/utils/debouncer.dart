import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Duration duration;
  Timer? _timer;
  Debouncer({required this.duration});
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  dispose() {
    _timer?.cancel();
  }
}
