import 'dart:async';

class Heartbeat {
  Timer? _timer;

  final void Function() _onTick;

  Heartbeat({required this._onTick}) {
    _init();
  }

  void ping() {
    _init();
    _onTick();
  }

  void _init() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 20), (_) {
      _onTick();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
