import 'dart:async';
import 'dart:ui';

class Throttler {
  final Duration delay;
  bool _isRunning = false;
  VoidCallback? _pendingAction;

  Throttler(this.delay);

  void call(VoidCallback action) {
    if (_isRunning) {
      _pendingAction = action;
      return;
    }

    _isRunning = true;
    action();

    _startTimer();
  }

  void _startTimer() {
    Timer(delay, () {
      final action = _pendingAction;
      if (action != null) {
        _pendingAction = null;
        action();
        _startTimer();
      } else {
        _isRunning = false;
      }
    });
  }
}
