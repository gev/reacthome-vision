import 'dart:async';
import 'dart:typed_data';

import 'package:vision/connection/connection.dart';
import 'package:vision/connection/heartbeat.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/url.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class DirectConnection extends Connection {
  late final Heartbeat _heartbeat;

  DirectConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required StreamController<Uint8List> source,
  }) {
    final client = ResilientWebSocket(
      getUrl: () => '${getUrl()}?peer=${Connection.peer.uuid}',
      sink: sink,
      policy: ExponentialBackoffPolicy(),
      source: source.stream.map(
        (message) =>
            (BytesBuilder(copy: false)
                  ..addByte(1)
                  ..add(message))
                .takeBytes(),
      ),
      onStateChange: setStatus,
    );
    client.start();
    _heartbeat = Heartbeat(
      onTick: () {
        source.add(_heartbeatData);
      },
    );
  }

  @override
  void dispose() {
    _heartbeat.dispose();
    super.dispose();
  }
}

final _heartbeatData = Uint8List.fromList([0]);
