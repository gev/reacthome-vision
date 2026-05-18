import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:vision/retry/retry.dart';
import 'package:vision/websocket/retryable_websocket.dart';
import 'package:vision/websocket/websocket_state.dart';

class ResilientWebSocket extends ChangeNotifier {
  late final Retry _retry;

  var _state = WebSocketState.disconnected;

  WebSocketState get state => _state;

  ResilientWebSocket({
    required String url,
    required Sink<Uint8List> sink,
    required Stream<Uint8List> source,
    // required OnWebSocketChangeState onStateChange,
    required RetryPolicy policy,
  }) {
    _retry = Retry(
      process: RetryableWebSocket(
        url: url,
        sink: sink,
        source: source,
        onStateChange: (newState) {
          _state = newState;
          notifyListeners();
        },
      ),
      policy: policy,
    );
  }

  Future<void> start() async {
    _retry.start();
  }
}
