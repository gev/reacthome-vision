import 'dart:async';

class Heartbeat {
  late final Timer _timer;

  Heartbeat({required void Function() onTick}) {
    onTick();
    _timer = Timer.periodic(Duration(seconds: 20), (_) {
      onTick();
    });
  }

  void dispose() {
    _timer.cancel();
  }
}
