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

typedef ModuleExpr = ({String name, Ir expr});

abstract class ReactiveRuntime extends ChangeNotifier {
  final Logger log;

  ReactiveRuntime({required this.log}) {
    _preloadModules();
  }

  void _preloadModules() async {
    var registered = false;
    final modules = await preloadModules();
    for (final module in modules) {
      final registeredModule = _tryRegisterModule(module.name, module.expr);
      if (registeredModule != null) {
        registered = true;
      }
    }
    if (registered) {
      _notifyListeners();
    }
  }

  Runtime get runtime;

  void loadModule(String name);

  Future<Iterable<ModuleExpr>> preloadModules();

  bool tryRegisterModule(String name, Ir expr) {
    final registeredModule = _tryRegisterModule(name, expr);
    if (registeredModule != null) {
      if (_cacheModule(registeredModule)) {
        _notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool _isDisposed = false;

  void _notifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  /// ToDo: Add module name verification
  RegisteredModule? _tryRegisterModule(String name, Ir expr) {
    switch (parseModule(expr)) {
      case Left(value: final error):
        log.error(error);
        return null;
      case Right(value: final module):
        reregisterModule(runtime.registry, module);
        return module;
    }
  }

  bool _cacheModule(RegisteredModule module) {
    final res = runEval(
      cacheImportedModule(module),
      runtime.copyWith(env: envFromModule(builtinModule)),
    );

    switch (res) {
      case Left(value: final error):
        log.error(error);
        return false;
      default:
        return true;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
