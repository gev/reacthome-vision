import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glue/either.dart';
import 'package:glue/env.dart';
import 'package:glue/ir.dart';
import 'package:glue/module/cache.dart';
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

  late Runtime _runtime;

  Runtime get actual => _runtime;

  ReactiveRuntime({
    required this._sink,
    required this._subscriber,
    required this._log,
  }) {
    _runtime = Runtime.initial(_env);
  }

  Env get _env =>
      makeEnv(sink: _sink, subscriber: _subscriber, runtime: this, log: _log);

  void _set(Runtime newRuntime) {
    if (newRuntime != _runtime) {
      _runtime = newRuntime;
      notifyListeners();
    }
  }

  @override
  void put(String name, Ir ir) {
    switch (parseModule(ir)) {
      case Left(value: final error):
        _log.error(error);
      case Right(value: final module):
        _set(
          actual.copyWith(
            registry: reregisterModule(actual.registry, module),
            importCache: removeFromCache(actual.importCache, name),
          ),
        );
    }
  }
}
