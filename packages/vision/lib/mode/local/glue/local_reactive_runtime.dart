import 'dart:io';

import 'package:glue/compile.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/parse.dart';
import 'package:glue/runtime.dart';
import 'package:path/path.dart' as p;
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/mode/local/glue/local_env.dart';
import 'package:vision/mode/local/local_storage.dart';

class LocalReactiveRuntime extends ReactiveRuntime {
  late final Runtime _runtime;
  late final String _path;

  LocalReactiveRuntime({
    required this._path,
    required LocalStorage storage,
    required super.log,
  }) {
    _runtime = Runtime.initial(
      makeLocalEnv(runtime: this, storage: storage, log: log),
    );
  }

  @override
  Runtime get runtime => _runtime;

  @override
  void loadModule(String name) {
    if (!isModuleRegistered(runtime.registry, name)) {
      loadModuleFromFile(
        name: name,
        path: p.setExtension(p.joinAll([_path, ...name.split('.')]), '.glue'),
      );
    }
  }

  void loadModuleFromFile({required String name, required String path}) {
    final file = File(path);
    file
        .readAsString()
        .then((glue) {
          parseGlue(glue).match(
            (error) {
              log.error(error.message);
            },
            (ast) {
              tryRegisterModule(name, compile(ast));
            },
          );
        })
        .catchError((error) {
          log.error(error.message);
        });
  }
}
