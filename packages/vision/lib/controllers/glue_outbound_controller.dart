import 'dart:async';

class GlueOutboundController {
  final Sink<String> _sink;
  late final Timer _timer;

  GlueOutboundController(this._sink) {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _emit();
    });
  }

  void _emit() {
    _sink.add("Hello Reacthome!!!");
  }

  void dispose() {
    _timer.cancel();
  }
}
