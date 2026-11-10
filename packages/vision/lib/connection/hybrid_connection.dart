import 'dart:typed_data';

import 'package:vision/connection/direct_connection.dart';
import 'package:vision/url.dart';

class HybridConnection {
  late final DirectConnection directConnection;
  HybridConnection({
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<String> source,
    required void Function() resubscribe,
  }) {
    directConnection = DirectConnection(
      getUrl: getUrl,
      sink: sink,
      source: source,
      resubscribe: resubscribe,
    );
  }

  void dispose() {
    directConnection.dispose();
  }
}
