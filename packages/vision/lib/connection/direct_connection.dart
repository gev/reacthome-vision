import 'dart:async';
import 'dart:typed_data';

import 'package:vision/connection/connection.dart';
import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/heartbeat.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/url.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class DirectConnection extends Connection {
  final _outbound = StreamController<Uint8List>();

  late final StreamSubscription<Uint8List> _sourceSubscription;

  late final Heartbeat _heartbeat = Heartbeat(
    onTick: () {
      _outbound.add(_heartbeatData);
    },
  );

  DirectConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<Uint8List> source,
  }) {
    final client = ResilientWebSocket(
      getUrl: () => '${getUrl()}?peer=${Connection.peer.uuid}',
      sink: sink,
      policy: ExponentialBackoffPolicy(),
      source: _outbound.stream,
      onStateChange: _onStatusChange,
    );
    client.start();
    _sourceSubscription = source.listen((data) {
      _outbound.add(
        (BytesBuilder(copy: false)
              ..addByte(1)
              ..add(data))
            .takeBytes(),
      );
    });
  }

  void _onStatusChange(ConnectionStatus status) {
    if (status == .connected) {
      _heartbeat.ping();
    }
    setStatus(status);
  }

  @override
  void dispose() {
    _heartbeat.dispose();
    _outbound.close();
    _sourceSubscription.cancel();
    super.dispose();
  }
}

final _heartbeatData = Uint8List.fromList([0]);
