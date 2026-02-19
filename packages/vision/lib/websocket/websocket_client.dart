import 'dart:async';
import 'dart:io';

import 'package:common/channel/broadcast_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// A WebSocket client with auto-reconnection support.
class WebSocketClient extends ChangeNotifier {
  final String _url;
  final BroadcastChannel<String> _channel;
  final WebSocketReconnectPolicy _reconnectPolicy;
  StreamSubscription<String>? _channelSubscription;
  WebSocket? _socket;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  bool _isManuallyDisconnected = false;
  Timer? _reconnectTimer;

  /// Current connection state.
  WebSocketConnectionState get state => _state;

  /// Creates a new WebSocket client and connects to the server.
  ///
  /// [url] - WebSocket server URL
  /// [channel] - Channel for message sharing between multiple clients
  WebSocketClient({
    required String url,
    required BroadcastChannel<String> channel,
  }) : _url = url,
       _channel = channel,
       _reconnectPolicy = WebSocketReconnectPolicy() {
    _channelSubscription = _channel.source.listen(_handleChannelMessage);
    _establishConnection();
  }

  void _handleChannelMessage(String message) {
    if (_state == WebSocketConnectionState.connected) {
      _socket?.add(message);
    }
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _isManuallyDisconnected = true;
    _reconnectTimer?.cancel();
    _updateState(WebSocketConnectionState.disconnected);
    await _closeSocket();
  }

  void _establishConnection() {
    _updateState(WebSocketConnectionState.connecting);
    WebSocket.connect(_url)
        .then((socket) {
          _socket = socket;
          _reconnectPolicy.recordSuccess();
          _updateState(WebSocketConnectionState.connected);

          socket.listen(
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
        })
        .catchError((e) {
          _onConnectionLost();
        });
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
