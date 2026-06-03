import 'dart:async';

typedef Fire = void Function();

class Watchdog {
  static const Duration defaultTimeout = Duration(seconds: 15);

  final Fire _fire;
  final Duration _timeout;

  bool _shouldFire = false;
  late Timer _timer;

  Watchdog({required this._fire, this._timeout = defaultTimeout}) {
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
