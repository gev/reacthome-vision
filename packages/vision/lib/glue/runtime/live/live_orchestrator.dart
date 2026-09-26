import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/runtime/live/assets_controller.dart';
import 'package:vision/glue/runtime/live/live_controller.dart';
import 'package:vision/glue/runtime/live/live_logger.dart';
import 'package:vision/glue/runtime/live/live_reactive_runtime.dart';
import 'package:vision/glue/runtime/live/live_storage.dart';
import 'package:vision/glue/runtime/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/url.dart';

class LiveOrchestrator {
  late final Logger log;
  final _monitor = connectionMonitor();
  late final ReactiveRuntime reactiveRuntime;

  late final LiveController _controller;
  late final GlueSubscriber _glueSubscriber;

  late final LiveStorage _storage;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  LiveOrchestrator({
    required GetUrl getUrl,
    required Directory path,
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
    _controller = LiveController(
      assetsController: AssetsController(assets: _storage.assets, log: log),
      glueController: GlueController(log: log),
      reactiveRuntime: reactiveRuntime,
      source: _inbound.stream,
    );
    DirectConnection(
      getUrl: getUrl,
      sink: _inbound,
      source: _outbound.stream,
      onStatusChange: _onStatusChange,
    );
  }

  void _onStatusChange(ConnectionStatus newState) {
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
