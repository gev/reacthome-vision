import 'dart:async';
import 'dart:io';

import 'package:common/channel/broadcast_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:vision/websocket/websocket_reconnect_policy.dart';
import 'package:vision/websocket/websocket_state.dart';
import 'package:vision/websocket/websocket_state_machine.dart';

/// A WebSocket client with auto-reconnection support.
///
/// Uses WebSocketConnectionStateMachine for state management.
class WebSocketClient extends ChangeNotifier {
  WebSocket? _socket;
  String? _url;
  final BroadcastChannel<String> _channel;
  StreamSubscription<String>? _channelSubscription;

  late final WebSocketConnectionStateMachine _stateMachine;

  /// Current connection state.
  WebSocketConnectionState get state => _stateMachine.state;

  /// Creates a new WebSocket client.
  ///
  /// [reconnectPolicy] - Optional reconnection policy for auto-reconnect
  /// [channel] - Channel for message sharing between multiple clients
  WebSocketClient({
    WebSocketReconnectPolicy? reconnectPolicy,
    required BroadcastChannel<String> channel,
  }) : _channel = channel,
       _stateMachine = WebSocketConnectionStateMachine(
         reconnectPolicy: reconnectPolicy,
       ) {
    _channelSubscription = _channel.source.listen(_handleChannelMessage);
    _stateMachine.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    notifyListeners();
  }

  void _handleChannelMessage(String message) {
    if (state == WebSocketConnectionState.connected) {
      _socket?.add(message);
    }
  }

  /// Connects to the WebSocket server at the specified URL.
  Future<void> connect(String url) async {
    _url = url;
    _stateMachine.connect();
    await _establishConnection();
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _stateMachine.disconnect();
    await _closeSocket();
  }

  /// Sends a message to the WebSocket server.
  void send(String message) {
    if (state != WebSocketConnectionState.connected) {
      throw StateError(
        'Cannot send message: WebSocket is not connected. Current state: $state',
      );
    }
    _socket?.add(message);
  }

  Future<void> _establishConnection() async {
    if (_url == null) return;

    try {
      _socket = await WebSocket.connect(_url!);
      _stateMachine.onConnected();

      // Listen for messages from WebSocket
      _socket!.listen(
        (data) {
          _channel.sink.emit(data);
        },
        onError: (error) {
          _stateMachine.onConnectionFailed();
        },
        onDone: () {
          _stateMachine.onConnectionClosed();
        },
      );
    } catch (e) {
      _stateMachine.onConnectionFailed();
    }
  }

  Future<void> _closeSocket() async {
    await _socket?.close();
  }

  @override
  void dispose() {
    _stateMachine.removeListener(_onStateChanged);
    _channelSubscription?.cancel();
    _closeSocket();
    _stateMachine.dispose();
    super.dispose();
  }
}
