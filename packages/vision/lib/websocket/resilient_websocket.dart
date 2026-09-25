import 'dart:typed_data';

import 'package:vision/retry/retry.dart';
import 'package:vision/websocket/retryable_websocket.dart';
import 'package:vision/websocket/session_state.dart';

class ResilientWebSocket {
  late final Retry _retry;

  ResilientWebSocket({
    required String? Function() getUrl,
    required Sink<Uint8List> sink,
    required Stream<Uint8List> source,
    required OnSessionStateChange onStateChange,
    required RetryPolicy policy,
  }) {
    _retry = Retry(
      process: RetryableWebSocket(
        getUrl: getUrl,
        sink: sink,
        source: source,
        onStateChange: onStateChange,
      ),
      policy: policy,
    );
  }

  Future<void> start() async {
    _retry.start();
  }
}
