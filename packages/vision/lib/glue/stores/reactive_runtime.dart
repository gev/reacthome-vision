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

class ReactiveRuntime extends ChangeNotifier implements Put<String, Ir> {
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

  @override
  void put(String name, Ir ir) {
    switch (parseModule(ir)) {
      case Left(value: final error):
        _log.error(error);
      case Right(value: final module):
        reregisterModule(runtime.registry, module);
        _cacheModule(module);
    }
  }

  void _cacheModule(RegisteredModule module) async {
    final res = await runEval(cacheImortedModule(module), runtime);
    res.match((error) => _log.error(error), (m) {
      print(m.$1.exportedValues);
      notifyListeners();
    });
  }
}
