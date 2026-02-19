import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// State machine for WebSocket connection - extends ChangeNotifier for reactive state.
class WebSocketConnectionStateMachine extends ChangeNotifier {
  final WebSocketReconnectPolicy _reconnectPolicy;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  bool _isManuallyDisconnected = false;
  Timer? _reconnectTimer;

  WebSocketConnectionStateMachine({WebSocketReconnectPolicy? reconnectPolicy})
    : _reconnectPolicy = reconnectPolicy ?? WebSocketReconnectPolicy();

  /// Current connection state.
  WebSocketConnectionState get state => _state;

  /// Initiates a connection attempt.
  void connect() {
    if (_state == WebSocketConnectionState.connecting ||
        _state == WebSocketConnectionState.connected) {
      return;
    }
    _isManuallyDisconnected = false;
    _setState(WebSocketConnectionState.connecting);
  }

  /// Called when connection is successfully established.
  void onConnected() {
    _reconnectPolicy.recordSuccess();
    _setState(WebSocketConnectionState.connected);
  }

  /// Called when connection attempt fails.
  void onConnectionFailed() {
    if (_isManuallyDisconnected) {
      _setState(WebSocketConnectionState.disconnected);
      return;
    }

    if (!_reconnectPolicy.canRetry) {
      _setState(WebSocketConnectionState.disconnected);
      return;
    }

    _scheduleReconnect();
  }

  /// Called when connection is closed (by server or error).
  void onConnectionClosed() {
    if (_isManuallyDisconnected) {
      _setState(WebSocketConnectionState.disconnected);
      return;
    }

    if (!_reconnectPolicy.canRetry) {
      _setState(WebSocketConnectionState.disconnected);
      return;
    }

    _scheduleReconnect();
  }

  /// Initiates manual disconnection.
  void disconnect() {
    _isManuallyDisconnected = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _setState(WebSocketConnectionState.disconnected);
  }

  void _scheduleReconnect() {
    _setState(WebSocketConnectionState.reconnecting);

    final delay = _reconnectPolicy.nextDelayMs;
    _reconnectPolicy.recordFailedAttempt();

    _reconnectTimer = Timer(Duration(milliseconds: delay), () {
      connect();
    });
  }

  void _setState(WebSocketConnectionState newState) {
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    super.dispose();
  }
}
