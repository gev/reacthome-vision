import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vision/connection/connection_state.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class Relay {
  late final Uint8List _from;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<Uint8List>();
  final _monitor = ValueNotifier(ConnectionStatus.disconnected);

  Relay(String url) {
    final peer = Uuid().v4obj();
    _from = peer.toBytes();
    final peerUrl = '$url/v1?peer=${peer.uuid}';
    final client = ResilientWebSocket(
      getUrl: () => peerUrl,
      sink: _inbound,
      source: _outbound.stream,
      onStateChange: (state) {
        _monitor.value = state;
      },
      policy: ExponentialBackoffPolicy(),
    );
    client.start();
  }

  BytesBuilder header(Uint8List to) => BytesBuilder(copy: false)
    ..add(_from)
    ..add(to);

  void pingPeer({required Uint8List to}) {
    final builder = header(to)..addByte(0);
    _outbound.add(builder.toBytes());
  }

  void sendTo({required Uint8List to, required Uint8List message}) {
    final builder = header(to)..add(message);
    _outbound.add(builder.toBytes());
  }
}
