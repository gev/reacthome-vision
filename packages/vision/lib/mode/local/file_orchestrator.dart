import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/local/glue/local_logger.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';
import 'package:vision/mode/local/glue/local_storage.dart';

class FileOrchestrator {
  late final Logger log;
  late final ReactiveRuntime reactiveRuntime;

  late final GlueSubscriber _glueSubscriber;

  late final LocalStorage _storage;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  FileOrchestrator({required Directory path}) {
    log = LocalLogger();

    _glueSubscriber = GlueSubscriber(request: GlueRequest(_outbound));

    _storage = LocalStorage(
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
  }

  void dispose() {
    _inbound.close();
    reactiveRuntime.dispose();
    _storage.dispose();
    _outbound.close();
  }
}
