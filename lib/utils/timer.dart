import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  Debounce({required this.duration});

  final Duration duration;
  Timer? _timer;

  void run(VoidCallback callback) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(duration, callback);
  }
}
