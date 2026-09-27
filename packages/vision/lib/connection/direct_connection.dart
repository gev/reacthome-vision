import 'dart:convert';
import 'dart:typed_data';

import 'package:vision/connection/connection.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/url.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class DirectConnection extends Connection {
  DirectConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<String> source,
  }) {
    final client = ResilientWebSocket(
      getUrl: getUrl,
      sink: sink,
      policy: ExponentialBackoffPolicy(),
      source: source.map(
        (message) =>
            (BytesBuilder(copy: false)
                  ..addByte(1)
                  ..add(utf8.encode(message)))
                .takeBytes(),
      ),
      onStateChange: onStatusChange,
    );
    client.start();
  }
}
