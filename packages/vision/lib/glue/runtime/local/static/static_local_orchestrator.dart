import 'dart:io';

import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/local_logger.dart';
import 'package:vision/glue/runtime/local/local_storage.dart';
import 'package:vision/glue/runtime/local/static/static_local_reactive_runtime.dart';
import 'package:vision/logger.dart';

class StaticLocalOrchestrator {
  final String _package;
  final DiscoveryStore _discoveryStore;

  late final Logger log;
  late final StaticLocalReactiveRuntime reactiveRuntime;
  late final LocalStorage _storage;

  StaticLocalOrchestrator({
    required Directory path,
    required this._package,
    required this._discoveryStore,
  }) {
    log = LocalLogger();

    _storage = LocalStorage(path: path, log: log);

    reactiveRuntime = StaticLocalReactiveRuntime(
      package: _package,
      storage: _storage,
      discoveryStore: _discoveryStore,
      log: log,
    );
  }

  void dispose() {
    reactiveRuntime.dispose();
    _storage.dispose();
  }
}
