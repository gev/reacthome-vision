import 'dart:typed_data';

import 'package:vision/mode/live/session/session_state.dart';
import 'package:vision/mode/live/websocket/retryable_websocket.dart';
import 'package:vision/retry/retry.dart';

class ResilientWebSocket {
  late final Retry _retry;

  ResilientWebSocket({
    required String url,
    required Sink<Uint8List> sink,
    required Stream<Uint8List> source,
    required OnSessionStateChange onStateChange,
    required RetryPolicy policy,
  }) {
    _retry = Retry(
      process: RetryableWebSocket(
        url: url,
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
