import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vision/mode/live/session/session_state.dart';
import 'package:vision/retry/retry.dart';

class RetryableWebSocket implements Retryable {
  final String url;
  final Sink<Uint8List> sink;
  final Stream<Uint8List> source;
  final OnSessionStateChange onStateChange;

  WebSocket? _socket;

  RetryableWebSocket({
    required this.url,
    required this.sink,
    required this.source,
    required this.onStateChange,
  }) {
    source.listen(_sendMessage, onDone: _onSourceClosed);
  }

  @override
  Future<bool> init() async {
    onStateChange(.connecting);
    try {
      _socket = await WebSocket.connect(url);
      onStateChange(.connected);
      return true;
    } catch (error, trace) {
      _onConnectionLost();
      log(error.toString(), stackTrace: trace);
      return false;
    }
  }

  @override
  Future<void> run() async {
    try {
      await _socket?.listen(_receiveMessage).asFuture();
    } catch (error, trace) {
      log(error.toString(), stackTrace: trace);
    }
    _onConnectionLost();
  }

  void _receiveMessage(dynamic message) {
    sink.add(message);
  }

  void _sendMessage(Uint8List message) {
    _socket?.add(message);
  }

  void _onConnectionLost() {
    onStateChange(.disconnected);
    _socket = null;
  }

  void _onSourceClosed() {
    _socket?.close();
  }
}
