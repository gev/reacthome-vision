import 'dart:typed_data';

import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/url.dart';

class HybridConnection {
  late final DirectConnection directConnection;
  HybridConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<String> source,
    required OnConnectionStatusChanged onStatusChanged,
  }) {
    directConnection = DirectConnection(
      getUrl: getUrl,
      sink: sink,
      source: source,
      onStatusChanged: onStatusChanged,
    );
  }

  void dispose() {
    directConnection.dispose();
  }
}
