import 'dart:async';
import 'dart:typed_data';

import 'package:vision/connection/connection.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/connection/relay_connection.dart';
import 'package:vision/url.dart';

class HybridConnection extends Connection {
  late final DirectConnection _directConnection;
  late final ConnectionMonitor _relayMonitor;

  final Uint8List _id;
  final _source = StreamController<Uint8List>();
  late final StreamSubscription<Uint8List> _sourceSubscription;

  HybridConnection({
    required this._id,
    required GetUrl getUrl,
    required Sink<Uint8List> sink,
    required Stream<Uint8List> source,
  }) {
    _relayMonitor = relayConnection.subscribe(
      id: _id,
      onMessage: (message) {
        if (_directConnection.monitor.value != ConnectionStatus.connected) {
          sink.add(message);
        }
      },
    );
    _relayMonitor.addListener(_setStatus);

    _directConnection = DirectConnection(
      getUrl: getUrl,
      sink: sink,
      source: _source.stream,
    );
    _directConnection.monitor.addListener(_setStatus);

    _sourceSubscription = source.listen((message) {
      if (_directConnection.monitor.value == .connected) {
        _source.add(message);
      } else {
        relayConnection.send(to: _id, message: message);
      }
    });
  }

  void _setStatus() {
    if (_directConnection.monitor.value == ConnectionStatus.connected) {
      setStatus(ConnectionStatus.connected);
    } else if (_relayMonitor.value == ConnectionStatus.connected) {
      setStatus(ConnectionStatus.connected);
    } else {
      setStatus(ConnectionStatus.disconnected);
    }
  }

  @override
  void dispose() {
    _directConnection.monitor.removeListener(_setStatus);
    _relayMonitor.removeListener(_setStatus);
    relayConnection.unsubscribe(id: _id);
    _source.close();
    _sourceSubscription.cancel();
    _directConnection.dispose();
    super.dispose();
  }
}
