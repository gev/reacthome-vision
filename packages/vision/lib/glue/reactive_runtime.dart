import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/module.dart';
import 'package:glue/module/import.dart';
import 'package:glue/module/registration.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/runtime.dart';
import 'package:vision/logger.dart';

abstract class ReactiveRuntime extends ChangeNotifier {
  final Logger log;

  ReactiveRuntime({required this.log});

  Runtime get runtime;

  void loadModule(String name);

  /// ToDo: Add module name verification
  bool tryRegisterModule(String name, Ir value) {
    switch (parseModule(value)) {
      case Left(value: final error):
        log.error(error);
        return false;
      case Right(value: final module):
        reregisterModule(runtime.registry, module);
        _cacheModule(module);
        return true;
    }
  }

  bool _isDisposed = false;

  void _cacheModule(RegisteredModule module) {
    final res = runEval(
      cacheImportedModule(module),
      runtime.copyWith(env: envFromModule(builtinModule)),
    );

    if (_isDisposed) return;

    res.match((error) => log.error(error), (m) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
