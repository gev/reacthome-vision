import 'dart:async';
import 'dart:io';

import 'package:common/channel/broadcast_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// A WebSocket client with auto-reconnection support.
class WebSocketClient extends ChangeNotifier {
  WebSocket? _socket;
  String? _url;
  final BroadcastChannel<String> _channel;
  StreamSubscription<String>? _channelSubscription;
  final WebSocketReconnectPolicy _reconnectPolicy;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  bool _isManuallyDisconnected = false;
  Timer? _reconnectTimer;

  /// Current connection state.
  WebSocketConnectionState get state => _state;

  /// Creates a new WebSocket client.
  ///
  /// [channel] - Channel for message sharing between multiple clients
  WebSocketClient({required BroadcastChannel<String> channel})
    : _channel = channel,
      _reconnectPolicy = WebSocketReconnectPolicy() {
    _channelSubscription = _channel.source.listen(_handleChannelMessage);
  }

  void _handleChannelMessage(String message) {
    if (_state == WebSocketConnectionState.connected) {
      _socket?.add(message);
    }
  }

  /// Connects to the WebSocket server at the specified URL.
  Future<void> connect() async {
    _isManuallyDisconnected = false;
    return _establishConnection();
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _isManuallyDisconnected = true;
    _reconnectTimer?.cancel();
    _updateState(WebSocketConnectionState.disconnected);
    return _closeSocket();
  }

  Future<void> _establishConnection() async {
    _updateState(WebSocketConnectionState.connecting);
    try {
      _socket = await WebSocket.connect(_url!);
      _reconnectPolicy.recordSuccess();
      _updateState(WebSocketConnectionState.connected);

      // Listen for messages from WebSocket
      _socket!.listen(
        (data) {
          _channel.sink.emit(data);
        },
        onError: (error) {
          _onConnectionLost();
        },
        onDone: () {
          _onConnectionLost();
        },
      );
    } catch (e) {
      _onConnectionLost();
    }
  }

  void _onConnectionLost() {
    _updateState(WebSocketConnectionState.disconnected);
    if (_isManuallyDisconnected) return;
    if (!_reconnectPolicy.canRetry) return;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    final delay = _reconnectPolicy.nextDelayMs;
    _reconnectPolicy.recordFailedAttempt();
    _reconnectTimer = Timer(Duration(milliseconds: delay), () {
      _establishConnection();
    });
  }

  void _updateState(WebSocketConnectionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> _closeSocket() async {
    await _socket?.close();
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    _channelSubscription?.cancel();
    _closeSocket();
    super.dispose();
  }
}
