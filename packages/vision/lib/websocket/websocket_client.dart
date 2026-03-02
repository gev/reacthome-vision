import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';

/// A WebSocket client with auto-reconnection support.
class WebSocketClient extends ChangeNotifier {
  final String _url;
  final Sink<String> _sink;
  final Stream<String> _source;
  final WebSocketReconnectPolicy _reconnectPolicy;

  StreamSubscription<String>? _subscription;
  WebSocket? _socket;

  WebSocketConnectionState _state = WebSocketConnectionState.disconnected;
  bool _isManuallyDisconnected = false;
  Timer? _reconnectTimer;

  /// Current connection state.
  WebSocketConnectionState get state => _state;

  /// Creates a new WebSocket client and connects to the server.
  ///
  /// [url] - WebSocket server URL
  /// [sink] - Sink for messages to send
  /// [source] - Stream for messages to receive
  WebSocketClient({
    required String url,
    required Sink<String> sink,
    required Stream<String> source,
    WebSocketReconnectPolicy? reconnectPolicy,
  }) : _url = url,
       _sink = sink,
       _source = source,
       _reconnectPolicy = reconnectPolicy ?? WebSocketReconnectPolicy() {
    _establishConnection();
  }

  /// Disconnects from the WebSocket server.
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
        (data) {
          final message = utf8.decode(data);
          print(message);
          // _sink.add(message);
        },
        onError: (error) {
          _onConnectionLost();
        },
        onDone: () {
          _onConnectionLost();
        },
      );
      _subscription = _source.listen(_handleChannelMessage);
    } catch (e) {
      print(e);
      _onConnectionLost();
    }
  }

  void _handleChannelMessage(String message) {
    print(message);
    final data = utf8.encode(message);
    _socket?.add(data);
  }

  void _onConnectionLost() {
    _updateState(WebSocketConnectionState.disconnected);
    _scheduleReconnect();
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
    _subscription?.cancel();
    _closeSocket();
    super.dispose();
  }
}
