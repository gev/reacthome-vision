import 'dart:async';

import 'package:glue/env.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/mode/live/glue/live_env.dart';
import 'package:vision/mode/live/live_storage.dart';
import 'package:vision/store/put.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/store/version.dart';
import 'package:vision/websocket/session_monitor.dart';

class LiveReactiveRuntime extends ReactiveRuntime
    implements Version<String, int>, Put<String, Revision<Ir, int>> {
  final StreamController<String> _sink;
  final GlueSubscriber _subscriber;
  final SessionMonitor _monitor;
  final LiveStorage _storage;

  final Map<String, int> _versions = {};

  late final Runtime _runtime;

  LiveReactiveRuntime({
    required this._storage,
    required this._sink,
    required this._subscriber,
    required this._monitor,
    required super.log,
  }) {
    _runtime = Runtime.initial(
      makeLiveEnv(
        sink: _sink,
        subscriber: _subscriber,
        runtime: this,
        storage: _storage,
        monitor: _monitor,
        log: log,
      ),
    );
  }

  @override
  Runtime get runtime => _runtime;

  @override
  int? version(String name) => _versions[name];

  @override
  void put(String name, Revision<Ir, int> value) {
    final registered = tryRegisterModule(name, value.payload);
    if (registered) {
      final db = _storage.glueDb;
      if (db != null) {
        final error = db.store(name, value);
        if (error != null) {
          log.error(error);
        }
      }
      _versions[name] = value.version;
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
}
