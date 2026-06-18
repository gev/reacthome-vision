import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:vision/controllers/controller.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/persistent/glue_assets.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';
import 'package:vision/glue/stores/tmp_store.dart';
import 'package:vision/persistent/assets.dart';
import 'package:vision/retry/exponentinal_backoff_policy.dart';
import 'package:vision/session/session_monitor.dart';
import 'package:vision/session/session_state.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class SessionOrchestrator {
  late final Logger log;
  final monitor = SessionMonitor();
  late final ReactiveRuntime reactiveRuntime;

  late final Controller _controller;
  late final GlueSubscriber _glueSubscriber;

  late final GlueDb? _glueDb;
  late final TmpStore _tmpStore;
  late final DataStore _dataStore;
  late final Assets _assets;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  SessionOrchestrator({
    required Directory path,
    required Directory tmp,
    required String host,
    required int port,
  }) {
    log = Logger(sink: _outbound);

    tmp.createSync(recursive: true);
    final dbDirectory = Directory(p.join(path.path, 'db'))
      ..createSync(recursive: true);
    final assetsDirectory = Directory(p.join(path.path, 'assets'))
      ..createSync(recursive: true);

    _glueSubscriber = GlueSubscriber(request: GlueRequest(_outbound));

    _glueDb = codeStore(dbDirectory, log);
    _tmpStore = TmpStore(_glueSubscriber);
    _dataStore = DataStore(dbDirectory, _glueSubscriber, log);
    _assets = assets(path: assetsDirectory, tmp: tmp, sink: _outbound);

    reactiveRuntime = ReactiveRuntime(
      glueDb: _glueDb,
      tmpStore: _tmpStore,
      dataStore: _dataStore,
      assets: _assets,
      sink: _outbound,
      subscriber: _glueSubscriber,
      log: log,
    );
    _controller = Controller(
      evaluator: GlueEvaluator(runtime: reactiveRuntime, log: log),
      source: _inbound.stream,
    );
    final client = _resilientWebSocket('ws://$host:$port');
    client.start();
  }

  ResilientWebSocket _resilientWebSocket(String url) => ResilientWebSocket(
    url: url,
    sink: _inbound,
    policy: ExponentialBackoffPolicy(),
    source: _outbound.stream.map(
      (message) =>
          (BytesBuilder(copy: false)
                ..addByte(1)
                ..add(utf8.encode(message)))
              .takeBytes(),
    ),
    onStateChange: _onStateChange,
  );

  void _onStateChange(SessionState newState) {
    monitor.state = newState;
    if (newState == .connected) {
      _glueSubscriber.resubscribeAll();
      _assets.reRequestAll();
    }
  }

  void dispose() {
    _controller.dispose();
    _inbound.close();
    monitor.dispose();
    reactiveRuntime.dispose();
    _tmpStore.dispose();
    _dataStore.dispose();
    _assets.dispose();
    _outbound.close();
  }
}
