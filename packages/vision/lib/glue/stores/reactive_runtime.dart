import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glue/either.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/module.dart';
import 'package:glue/module/cache.dart';
import 'package:glue/module/import.dart';
import 'package:glue/module/registration.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/runtime.dart';
import 'package:path/path.dart' as p;
import 'package:vision/glue/env.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/persistent/glue_assets.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/tmp_store.dart';
import 'package:vision/persistent/assets.dart';
import 'package:vision/store/put.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/store/version.dart';

class ReactiveRuntime extends ChangeNotifier
    implements Version<String, int>, Put<String, Revision<Ir, int>> {
  final StreamController<String> _sink;
  final GlueSubscriber _subscriber;
  final Logger _log;

  late final GlueDb? _db;
  late final TmpStore _tmpStore;
  late final DataStore _dataStore;
  late final Assets _assets;

  late final Runtime runtime;

  bool _isDisposed = false;

  ReactiveRuntime({
    required Directory path,
    required Directory tmp,
    required this._sink,
    required this._subscriber,
    required this._log,
  }) {
    tmp.createSync(recursive: true);
    final dbDirectory = Directory(p.join(path.path, 'db'))
      ..createSync(recursive: true);
    final assetsDirectory = Directory(p.join(path.path, 'assets'))
      ..createSync(recursive: true);
    _db = codeStore(dbDirectory, _log);
    _tmpStore = TmpStore(_subscriber);
    _dataStore = DataStore(dbDirectory, _subscriber, _log);
    _assets = assets(path: assetsDirectory, tmp: tmp, sink: _sink);
    runtime = Runtime.initial(_env);
  }

  Env get _env => makeEnv(
    sink: _sink,
    subscriber: _subscriber,
    runtime: this,
    tmpStore: _tmpStore,
    dataStore: _dataStore,
    assets: _assets,
    log: _log,
  );

  final Map<String, int> _versions = {};

  @override
  int? version(String name) => _versions[name];

  @override
  void put(String name, Revision<Ir, int> value) {
    _registerModule(name, value);
    if (_db != null) {
      final error = _db.store(name, value);
      if (error != null) {
        _log.error(error);
      }
    }
  }

  void loadModule(String name) {
    if (_db != null && !isModuleCached(runtime.importCache, name)) {
      switch (_db.lookup(name)) {
        case Right(:final value):
          _registerModule(name, value);
        case Left(value: final error):
          _log.error(error.message);
      }
    }
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

  void _cacheModule(RegisteredModule module) async {
    final res = await runEval(
      cacheImortedModule(module),
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
    _tmpStore.dispose();
    _dataStore.dispose();
    _assets.dispose();
    super.dispose();
  }
}
