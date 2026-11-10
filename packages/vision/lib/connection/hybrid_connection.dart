import 'dart:typed_data';

import 'package:vision/connection/connection.dart';
import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/url.dart';

class HybridConnection extends Connection {
  late final DirectConnection _directConnection;

  HybridConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<String> source,
    required OnConnectionStatusChanged onStatusChanged,
  }) {
    _directConnection = DirectConnection(
      getUrl: getUrl,
      sink: sink,
      source: source,
      onStatusChanged: onStatusChanged,
    );
    _directConnection.monitor.addListener(() {
      setStatus(_directConnection.monitor.value);
    });
  }

  @override
  void dispose() {
    _directConnection.dispose();
    super.dispose();
  }
}
