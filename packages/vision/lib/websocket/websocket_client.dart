import 'dart:async';
import 'dart:io';

import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// A WebSocket client with auto-reconnection support.
///
/// This client automatically reconnects when the connection is lost,
/// using an exponential backoff strategy to avoid overwhelming the server.
class WebSocketClient {
  WebSocket? _socket;
  final _messageController = StreamController<String>.broadcast();
  final _connectionStateController =
      StreamController<WebSocketConnectionState>.broadcast();

  Timer? _reconnectTimer;
  String? _url;
  WebSocketReconnectPolicy _reconnectPolicy;
  bool _isManuallyDisconnected = false;

  /// Stream of incoming messages.
  Stream<String> get messages => _messageController.stream;

  /// Stream of connection state changes.
  Stream<WebSocketConnectionState> get connectionState =>
      _connectionStateController.stream;

  /// Current connection state.
  WebSocketConnectionState _connectionState =
      WebSocketConnectionState.disconnected;
  WebSocketConnectionState get connectionStateSync => _connectionState;

  /// Creates a new WebSocket client with the specified reconnection policy.
  WebSocketClient({WebSocketReconnectPolicy? reconnectPolicy})
    : _reconnectPolicy = reconnectPolicy ?? WebSocketReconnectPolicy();

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
    _reconnectTimer = null;
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

      // Listen for messages
      _socket!.listen(
        (data) {
          if (data is String) {
            _messageController.add(data);
          }
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
    _connectionStateController.add(state);
  }

  Future<void> _closeSocket() async {
    await _socket?.close();
    _socket = null;
  }

  /// Disposes of the client and releases resources.
  Future<void> dispose() async {
    _reconnectTimer?.cancel();
    await _closeSocket();
    await _messageController.close();
    await _connectionStateController.close();
  }
}
