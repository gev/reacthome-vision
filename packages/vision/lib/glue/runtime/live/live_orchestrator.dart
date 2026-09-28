import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:glue/module.dart';
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

abstract class LiveOrchestrator {
  late final Logger log;
  late final ReactiveRuntime reactiveRuntime;

  late final LiveController _controller;
  late final GlueSubscriber _glueSubscriber;

  late final LiveStorage _storage;

  final inbound = StreamController<Uint8List>();
  final outbound = StreamController<String>();

  LiveOrchestrator({
    required Directory path,
    required DiscoveryStore discoveryStore,
  }) {
    log = LiveLogger(sink: outbound);
    _glueSubscriber = GlueSubscriber(request: GlueRequest(outbound));
    _storage = LiveStorage(
      path: path,
      subscriber: _glueSubscriber,
      sink: outbound,
      log: log,
    );
    reactiveRuntime = LiveReactiveRuntime(
      sink: outbound,
      subscriber: _glueSubscriber,
      storage: _storage,
      discoveryStore: discoveryStore,
      connectivityModule: connectivityModule,
      log: log,
    );
    _controller = LiveController(
      assetsController: AssetsController(assets: _storage.assets, log: log),
      glueController: GlueController(log: log),
      reactiveRuntime: reactiveRuntime,
      source: inbound.stream,
    );
  }

  ModuleInfo get connectivityModule;

  void resubscribe() {
    _glueSubscriber.resubscribeAll();
    _storage.assets.reRequestAll();
  }

  void dispose() {
    _controller.dispose();
    inbound.close();
    reactiveRuntime.dispose();
    _storage.dispose();
    outbound.close();
  }
}
