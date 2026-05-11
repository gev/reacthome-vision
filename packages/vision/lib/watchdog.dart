import 'dart:async';

class Watchdog {
  final void Function() _fire;
  final Duration _timeout;

  bool _shouldFire = false;
  late Timer _timer;

  Watchdog({
    required void Function() fire,
    Duration timeout = const Duration(seconds: 15),
  }) : _fire = fire,
       _timeout = timeout {
    _timer = _next;
  }

  void feed() {
    _timer.cancel();
    _timer = _next;
    if (_shouldFire) {
      _fire();
      _shouldFire = false;
    }
  }

  void shouldFire() {
    _timer.cancel();
    _shouldFire = true;
  }

  Timer get _next => Timer(_timeout, () {
    _shouldFire = true;
  });

  void dispose() {
    _timer.cancel();
  }
}
