import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// A WebSocket client with auto-reconnection support.
class WebSocketClient<T> extends ChangeNotifier {
  final String _url;
  final StreamController<T> _channel;
  final WebSocketReconnectPolicy _reconnectPolicy;
  late final StreamSubscription<T> _channelSubscription;
  WebSocket? _socket;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  bool _isManuallyDisconnected = false;
  Timer? _reconnectTimer;

  /// Current connection state.
  WebSocketConnectionState get state => _state;

  /// Creates a new WebSocket client and connects to the server.
  ///
  /// [url] - WebSocket server URL
  /// [channel] - Channel for messages to send and receive
  WebSocketClient({
    required String url,
    required StreamController<T> channel,
    WebSocketReconnectPolicy? reconnectPolicy,
  }) : _url = url,
       _channel = channel,
       _reconnectPolicy = reconnectPolicy ?? WebSocketReconnectPolicy() {
    _channelSubscription = _channel.stream.listen(_handleChannelMessage);
    _establishConnection();
  }

  void _handleChannelMessage(T message) {
    if (_state == WebSocketConnectionState.connected) {
      _socket?.add(message);
    }
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _isManuallyDisconnected = true;
    _updateState(WebSocketConnectionState.disconnected);
    return _closeSocket();
  }

  Future<void> _establishConnection() async {
    _updateState(WebSocketConnectionState.connecting);
    _socket = await WebSocket.connect(_url);
    _reconnectPolicy.recordSuccess();
    _updateState(WebSocketConnectionState.connected);

    _socket!.listen(
      (data) {
        _channel.sink.add(data);
      },
      onError: (error) {
        _onConnectionLost();
      },
      onDone: _onConnectionLost,
    );
  }

  void _onConnectionLost() {
    _updateState(WebSocketConnectionState.disconnected);
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_isManuallyDisconnected) return;
    if (!_reconnectPolicy.canRetry) return;
    final delay = _reconnectPolicy.nextDelayMs;
    _reconnectPolicy.recordFailedAttempt();
    _reconnectTimer = Timer(
      Duration(milliseconds: delay),
      _establishConnection,
    );
  }

  void _updateState(WebSocketConnectionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> _closeSocket() async => _socket?.close();

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    _channelSubscription.cancel();
    _closeSocket();
    super.dispose();
  }
}
