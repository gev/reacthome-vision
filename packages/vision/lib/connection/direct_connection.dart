import 'dart:async';
import 'dart:typed_data';

import 'package:vision/connection/connection.dart';
import 'package:vision/connection/heartbeat.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/url.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class DirectConnection extends Connection {
  late final Heartbeat _heartbeat;

  final _outbound = StreamController<Uint8List>();
  late final StreamSubscription<Uint8List> _sourceSubscription;

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
      onStateChange: setStatus,
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
    _heartbeat = Heartbeat(
      onTick: () {
        _outbound.add(_heartbeatData);
      },
    );
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
