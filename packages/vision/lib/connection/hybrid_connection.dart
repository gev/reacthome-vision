import 'dart:typed_data';

import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/url.dart';

class HybridConnection {
  HybridConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<String> source,
    required OnConnectionStatusChange onConnectionStatusChange,
  }) {
    DirectConnection(
      getUrl: getUrl,
      sink: sink,
      source: source,
      onConnectionStatusChange: onConnectionStatusChange,
    );
  }
}
