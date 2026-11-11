import 'dart:async';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:vision/connection/connection.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/websocket/resilient_websocket.dart';

final relayUrl = 'wss://relay.reacthome.net';

final relayConnection = RelayConnection(url: relayUrl);

typedef OnRelayMessage = void Function(Uint8List message);

class Peer {
  final ConnectionMonitor monitor = makeConnectionMonitor();
  final OnRelayMessage _onMessage;

  late final Timer _ping;
  Timer? _timeout;

  void onMessage(Uint8List message) {
    _timeout?.cancel();
    _timeout = Timer(const Duration(seconds: 30), () {
      monitor.value = .disconnected;
    });
    monitor.value = .connected;
    _onMessage(message);
  }

  Peer(Uint8List id, this._onMessage) {
    _ping = Timer.periodic(const Duration(seconds: 20), (_) {
      relayConnection.ping(to: id);
    });
  }

  void dispose() {
    _timeout?.cancel();
    _ping.cancel();
  }
}

class RelayConnection extends Connection {
  late final Uint8List _from;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<Uint8List>();

  final Map<Uint8List, Peer> _peers = {};

  late final StreamSubscription<Uint8List> _inboundSubscription;

  RelayConnection({required String url}) {
    final peer = Uuid().v4obj();
    _from = peer.toBytes();
    _inboundSubscription = _inbound.stream.listen(_handleInbound);
    final peerUrl = '$url/v1?peer=${peer.uuid}';
    final client = ResilientWebSocket(
      getUrl: () => peerUrl,
      sink: _inbound,
      source: _outbound.stream,
      policy: ExponentialBackoffPolicy(),
      onStateChange: setStatus,
    );
    client.start();
  }

  BytesBuilder header(Uint8List to) => BytesBuilder(copy: false)
    ..add(_from)
    ..add(to);

  void ping({required Uint8List to}) {
    final builder = header(to)..addByte(0);
    _outbound.add(builder.toBytes());
  }

  void send({required Uint8List to, required Uint8List message}) {
    final builder = header(to)..add(message);
    _outbound.add(builder.toBytes());
  }

  ConnectionMonitor subscribe({
    required Uint8List id,
    required OnRelayMessage onMessage,
  }) {
    final peer = Peer(id, onMessage);
    _peers[id] = peer;
    return peer.monitor;
  }

  void unsubscribe({required Uint8List id}) {
    _peers[id]?.dispose();
    _peers.remove(id);
  }

  void _handleInbound(Uint8List message) {
    if (message.length < 32) {
      return;
    }
    final from = message.sublist(0, 16);
    final payload = message.sublist(32);
    final peer = _peers[from];
    if (peer != null) {
      peer.onMessage(payload);
    }
  }

  @override
  void dispose() {
    for (final peer in _peers.values) {
      peer.dispose();
    }
    _inbound.close();
    _outbound.close();
    _inboundSubscription.cancel();
    super.dispose();
  }
}
