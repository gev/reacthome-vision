import 'dart:async';

import 'package:glue/either.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/module.dart';
import 'package:glue/module/import.dart';
import 'package:glue/module/registration.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/live/glue/live_env.dart';
import 'package:vision/storage.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/websocket/session_monitor.dart';

class LiveReactiveRuntime extends ReactiveRuntime {
  final StreamController<String> _sink;
  final GlueSubscriber _subscriber;
  final SessionMonitor _monitor;
  final Logger _log;

  final Storage _storage;

  late final Runtime _runtime;

  bool _isDisposed = false;

  LiveReactiveRuntime({
    required this._storage,
    required this._sink,
    required this._subscriber,
    required this._monitor,
    required this._log,
  }) {
    _runtime = Runtime.initial(_env);
  }

  Env get _env => makeLiveEnv(
    sink: _sink,
    subscriber: _subscriber,
    runtime: this,
    storage: _storage,
    monitor: _monitor,
    log: _log,
  );

  final Map<String, int> _versions = {};

  @override
  Runtime get runtime => _runtime;

  @override
  int? version(String name) => _versions[name];

  @override
  void put(String name, Revision<Ir, int> value) {
    _registerModule(name, value);
    final db = _storage.glueDb;
    if (db != null) {
      final error = db.store(name, value);
      if (error != null) {
        _log.error(error);
      }
    }
  }

  @override
  void loadModule(String name) {
    // final db = _storage.glueDb;
    // if (db != null && !isModuleRegistered(runtime.registry, name)) {
    //   switch (db.lookup(name)) {
    //     case Right(:final value):
    //       _registerModule(name, value);
    //     case Left(value: final error):
    //       _log.error(error.message);
    //   }
    // }
  }

  void _registerModule(String name, Revision<Ir, int> value) {
    switch (parseModule(value.payload)) {
      case Left(value: final error):
        _log.error(error);
      case Right(value: final module):
        reregisterModule(runtime.registry, module);
        _cacheModule(module);
        _versions[name] = value.version;
    }
  }

  void _cacheModule(RegisteredModule module) {
    final res = runEval(
      cacheImportedModule(module),
      runtime.copyWith(env: envFromModule(builtinModule)),
    );

    if (_isDisposed) return;

    res.match((error) => _log.error(error), (m) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
