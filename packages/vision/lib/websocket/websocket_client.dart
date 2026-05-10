import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

class WebSocketClient extends ChangeNotifier {
  final String _url;
  final Sink<String> _sink;
  final Stream<String> _source;
  final WebSocketReconnectPolicy _reconnectPolicy;

  late final StreamSubscription<String> _subscription;

  WebSocket? _socket;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  bool _isManuallyDisconnected = false;
  Timer? _reconnectTimer;

  WebSocketConnectionState get state => _state;

  WebSocketClient({
    required String url,
    required Sink<String> sink,
    required Stream<String> source,
    WebSocketReconnectPolicy? reconnectPolicy,
  }) : _url = url,
       _sink = sink,
       _source = source,
       _reconnectPolicy = reconnectPolicy ?? WebSocketReconnectPolicy() {
    _subscription = _source.listen(_sendMessage);
    _establishConnection();
  }

  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _isManuallyDisconnected = true;
    _updateState(WebSocketConnectionState.disconnected);
    _closeSocket();
  }

  Future<void> _establishConnection() async {
    _updateState(WebSocketConnectionState.connecting);
    try {
      _socket = await WebSocket.connect(_url);
      _reconnectPolicy.recordSuccess();
      _updateState(WebSocketConnectionState.connected);
      _socket!.listen(
        _receiveMessage,
        onDone: _onConnectionLost,
        cancelOnError: true,
      );
    } catch (_) {
      _onConnectionLost();
    }
  }

  void _receiveMessage(dynamic data) {
    final message = utf8.decode(data);
    _sink.add(message);
  }

  void _sendMessage(String message) {
    _socket?.add(utf8.encode(message));
  }

  void _onConnectionLost() {
    _updateState(WebSocketConnectionState.disconnected);
    _scheduleReconnect();
    _socket = null;
  }

  void _scheduleReconnect() {
    if (!_isManuallyDisconnected && _reconnectPolicy.canRetry) {
      final delay = _reconnectPolicy.nextDelayMs;
      _reconnectPolicy.recordFailedAttempt();
      _reconnectTimer = Timer(
        Duration(milliseconds: delay),
        _establishConnection,
      );
    }
  }

  void _updateState(WebSocketConnectionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> _closeSocket() async => _socket?.close();

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    _subscription.cancel();
    _closeSocket();
    super.dispose();
  }
}
