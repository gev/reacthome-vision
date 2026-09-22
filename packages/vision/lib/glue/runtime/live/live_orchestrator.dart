import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/runtime/live/assets_controller.dart';
import 'package:vision/glue/runtime/live/controller.dart';
import 'package:vision/glue/runtime/live/live_logger.dart';
import 'package:vision/glue/runtime/live/live_reactive_runtime.dart';
import 'package:vision/glue/runtime/live/live_storage.dart';
import 'package:vision/glue/runtime/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/retry/exponential_backoff_policy.dart';
import 'package:vision/websocket/resilient_websocket.dart';
import 'package:vision/websocket/session_monitor.dart';
import 'package:vision/websocket/session_state.dart';

class LiveOrchestrator {
  late final Logger log;
  final _monitor = sessionMonitor();
  late final ReactiveRuntime reactiveRuntime;

  late final Controller _controller;
  late final GlueSubscriber _glueSubscriber;

  late final LiveStorage _storage;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  LiveOrchestrator({
    required Directory path,
    required String url,
    required DiscoveryStore discoveryStore,
  }) {
    log = LiveLogger(sink: _outbound);

    _glueSubscriber = GlueSubscriber(request: GlueRequest(_outbound));

    _storage = LiveStorage(
      path: path,
      subscriber: _glueSubscriber,
      sink: _outbound,
      log: log,
    );

    reactiveRuntime = LiveReactiveRuntime(
      sink: _outbound,
      subscriber: _glueSubscriber,
      monitor: _monitor,
      storage: _storage,
      discoveryStore: discoveryStore,
      log: log,
    );
    _controller = Controller(
      assetsController: AssetsController(assets: _storage.assets, log: log),
      glueController: GlueController(log: log),
      reactiveRuntime: reactiveRuntime,
      source: _inbound.stream,
    );
    final client = _resilientWebSocket(url);
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
