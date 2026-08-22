import 'dart:async';
import 'dart:ui';

class Throttler {
  final Duration delay;
  bool _isRunning = false;

  Throttler({required this.delay});

  void call(VoidCallback action) {
    if (_isRunning) return;

    _isRunning = true;
    action();

    Timer(delay, () {
      _isRunning = false;
    });
  }
}
