import 'package:glue/env.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/mode/local/glue/local_env.dart';

class LocalReactiveRuntime extends ReactiveRuntime {
  late final Runtime _runtime;

  LocalReactiveRuntime({required super.log}) {
    _runtime = Runtime.initial(makeLocalEnv(runtime: this, log: log));
  }

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
