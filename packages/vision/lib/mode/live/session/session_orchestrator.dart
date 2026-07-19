import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/mode/live/controllers/assets_controller.dart';
import 'package:vision/mode/live/controllers/controller.dart';
import 'package:vision/mode/live/glue/live_reactive_runtime.dart';
import 'package:vision/mode/live/session/session_monitor.dart';
import 'package:vision/mode/live/session/session_state.dart';
import 'package:vision/mode/live/websocket/resilient_websocket.dart';
import 'package:vision/retry/exponentinal_backoff_policy.dart';
import 'package:vision/storage.dart';

class SessionOrchestrator {
  late final Logger log;
  final _monitor = sessionMonitor();
  late final LiveReactiveRuntime reactiveRuntime;

  late final Controller _controller;
  late final GlueSubscriber _glueSubscriber;

  late final Storage _storage;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  SessionOrchestrator({
    required Directory path,
    required String host,
    required int port,
  }) {
    log = Logger(sink: _outbound);

    _glueSubscriber = GlueSubscriber(request: GlueRequest(_outbound));

    _storage = Storage(
      path: path,
      subscriber: _glueSubscriber,
      sink: _outbound,
      log: log,
    );

    reactiveRuntime = LiveReactiveRuntime(
      storage: _storage,
      sink: _outbound,
      subscriber: _glueSubscriber,
      monitor: _monitor,
      log: log,
    );
    _controller = Controller(
      assetsController: AssetsController(assets: _storage.assets, log: log),
      glueController: GlueController(runtime: reactiveRuntime, log: log),
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
    _monitor.value = newState;
    if (newState == .connected) {
      _glueSubscriber.resubscribeAll();
      _storage.assets.reRequestAll();
    }
  }

  void dispose() {
    _controller.dispose();
    _inbound.close();
    _monitor.dispose();
    reactiveRuntime.dispose();
    _storage.dispose();
    _outbound.close();
  }
}
