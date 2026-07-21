import 'dart:async';

import 'package:glue/env.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/mode/local/glue/local_env.dart';
import 'package:vision/mode/local/glue/local_storage.dart';

class LocalReactiveRuntime extends ReactiveRuntime {
  final StreamController<String> _sink;
  final GlueSubscriber _subscriber;
  final LocalStorage _storage;

  late final Runtime _runtime;

  LocalReactiveRuntime({
    required this._storage,
    required this._sink,
    required this._subscriber,
    required super.log,
  }) {
    _runtime = Runtime.initial(_env);
  }

  Env get _env => makeLocalEnv(
    sink: _sink,
    subscriber: _subscriber,
    runtime: this,
    storage: _storage,
    log: log,
  );

  @override
  Runtime get runtime => _runtime;

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
}
