import 'dart:async';
import 'dart:io';

import 'package:common/channel/broadcast_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// A WebSocket client with auto-reconnection support.
///
/// This client automatically reconnects when the connection is lost,
/// using an exponential backoff strategy to avoid overwhelming the server.
class WebSocketClient extends ChangeNotifier {
  WebSocket? _socket;

  Timer? _reconnectTimer;
  String? _url;
  WebSocketReconnectPolicy _reconnectPolicy;
  bool _isManuallyDisconnected = false;
  final BroadcastChannel<String> _channel;
  StreamSubscription<String>? _channelSubscription;

  /// Current connection state.
  WebSocketConnectionState _connectionState =
      WebSocketConnectionState.disconnected;
  WebSocketConnectionState get state => _connectionState;

  /// Creates a new WebSocket client.
  ///
  /// [reconnectPolicy] - Optional reconnection policy for auto-reconnect
  /// [channel] - Channel for message sharing between multiple clients
  WebSocketClient({
    WebSocketReconnectPolicy? reconnectPolicy,
    required BroadcastChannel<String> channel,
  }) : _reconnectPolicy = reconnectPolicy ?? WebSocketReconnectPolicy(),
       _channel = channel {
    _channelSubscription = _channel.source.listen(_handleChannelMessage);
  }

  void _handleChannelMessage(String message) {
    if (_connectionState == WebSocketConnectionState.connected) {
      _socket?.add(message);
    }
  }

  /// Connects to the WebSocket server at the specified URL.
  Future<void> connect(String url) async {
    _url = url;
    _isManuallyDisconnected = false;
    await _establishConnection();
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _isManuallyDisconnected = true;
    _reconnectTimer?.cancel();
    await _closeSocket();
    _updateConnectionState(WebSocketConnectionState.disconnected);
  }

  /// Sends a message to the WebSocket server.
  void send(String message) {
    if (_connectionState != WebSocketConnectionState.connected) {
      throw StateError(
        'Cannot send message: WebSocket is not connected. Current state: $_connectionState',
      );
    }
    _socket?.add(message);
  }

  /// Updates the reconnection policy.
  void updateReconnectPolicy(WebSocketReconnectPolicy policy) {
    _reconnectPolicy = policy;
  }

  Future<void> _establishConnection() async {
    if (_url == null) return;

    _updateConnectionState(WebSocketConnectionState.connecting);

    try {
      _socket = await WebSocket.connect(_url!);
      _reconnectPolicy.recordSuccess();
      _updateConnectionState(WebSocketConnectionState.connected);

      // Listen for messages from WebSocket
      _socket.listen(
        (data) {
          _channel.sink.emit(data);
        },
        onError: (error) {
          _handleConnectionError(error);
        },
        onDone: () {
          _handleConnectionClosed();
        },
      );
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  void _handleConnectionError(dynamic error) {
    if (!_isManuallyDisconnected) {
      _scheduleReconnect();
    }
  }

  void _handleConnectionClosed() {
    if (!_isManuallyDisconnected) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_isManuallyDisconnected) return;

    if (!_reconnectPolicy.canRetry) {
      _updateConnectionState(WebSocketConnectionState.disconnected);
      return;
    }

    _reconnectTimer?.cancel();
    _updateConnectionState(WebSocketConnectionState.reconnecting);

    final delay = _reconnectPolicy.nextDelayMs;
    _reconnectPolicy.recordFailedAttempt();

    _reconnectTimer = Timer(Duration(milliseconds: delay), () {
      _establishConnection();
    });
  }

  void _updateConnectionState(WebSocketConnectionState state) {
    _connectionState = state;
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
