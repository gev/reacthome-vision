import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:glue/module.dart';
import 'package:glue/module/cache.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/stores/put.dart';

class ReactiveRuntime implements Put<String, RegisteredModule> {
  final StreamController<String> _sink;
  final Logger _log;

  late final ValueNotifier<Runtime> _runtime;
  late final GlueSubscriber _glueSubscriber;
  late final ModuleSubscriber _moduleSubscriber;

  Runtime get runtime => _runtime.value;

  ReactiveRuntime({required this._sink, required this._log}) {
    _glueSubscriber = GlueSubscriber(subscribe: GlueRequest(_sink));
    _moduleSubscriber = ModuleSubscriber(
      subscribe: ModuleRequest(_sink),
      store: this,
    );
    _runtime = ValueNotifier(Runtime.initial(_env));
  }

  void resubscribe() {
    _glueSubscriber.resubscribeAll();
    _moduleSubscriber.resubscribeAll();
  }

  Env get _env => makeEnv(
    sink: _sink,
    glueSubscriber: _glueSubscriber,
    moduleSubscriber: _moduleSubscriber,
    log: _log,
  );

  @override
  void put(String name, RegisteredModule module) {
    _runtime.value = runtime.copyWith(
      registry: reregisterModule(runtime.registry, module),
      importCache: removeFromCache(runtime.importCache, name),
    );
  }

  void dispose() {
    _runtime.dispose();
  }
}
