import 'dart:async';
import 'dart:developer';

class GlueInboundController {
  late final StreamSubscription<String> _subscription;

  GlueInboundController(Stream<String> source) {
    _subscription = source.listen(_onData);
  }

  void _onData(String message) {
    log(message);
  }

  void dispose() {
    _subscription.cancel();
  }
}
