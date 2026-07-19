import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/mode/live/assets_controller.dart';
import 'package:vision/mode/live/controller.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';
import 'package:vision/storage.dart';

class FileOrchestrator {
  late final Logger log;
  late final ReactiveRuntime reactiveRuntime;

  late final Controller _controller;
  late final GlueSubscriber _glueSubscriber;

  late final Storage _storage;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  FileOrchestrator({required Directory path}) {
    log = Logger(sink: _outbound);

    _glueSubscriber = GlueSubscriber(request: GlueRequest(_outbound));

    _storage = Storage(
      path: path,
      subscriber: _glueSubscriber,
      sink: _outbound,
      log: log,
    );

    reactiveRuntime = LocalReactiveRuntime(
      storage: _storage,
      sink: _outbound,
      subscriber: _glueSubscriber,
      log: log,
    );
    _controller = Controller(
      assetsController: AssetsController(assets: _storage.assets, log: log),
      glueController: GlueController(runtime: reactiveRuntime, log: log),
      source: _inbound.stream,
    );
  }

  void dispose() {
    _controller.dispose();
    _inbound.close();
    reactiveRuntime.dispose();
    _storage.dispose();
    _outbound.close();
  }
}
