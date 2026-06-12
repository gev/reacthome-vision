import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glue/either.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/module.dart';
import 'package:glue/module/import.dart';
import 'package:glue/module/registration.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/stores/put.dart';
import 'package:vision/stores/revision.dart';
import 'package:vision/stores/version.dart';

class ReactiveRuntime extends ChangeNotifier
    implements Version<String, int>, Put<String, Revision<Ir, int>> {
  final StreamController<String> _sink;
  final GlueSubscriber _subscriber;
  final Logger _log;

  late final Runtime runtime;

  ReactiveRuntime({
    required this._sink,
    required this._subscriber,
    required this._log,
  }) {
    runtime = Runtime.initial(_env);
  }

  Env get _env =>
      makeEnv(sink: _sink, subscriber: _subscriber, runtime: this, log: _log);

  final Map<String, int> _versions = {};

  @override
  int? version(String name) => _versions[name];

  @override
  void put(String name, Revision<Ir, int> value) {
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
    final res = await runEval(cacheImortedModule(module), runtime);
    res.match((error) => _log.error(error), (m) {
      notifyListeners();
    });
  }
}
