import 'dart:io';

import 'package:glue/compile.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/parse.dart';
import 'package:path/path.dart' as p;
import 'package:vision/glue/runtime/local/local_reactive_runtime.dart';

class DynamicLocalReactiveRuntime extends LocalReactiveRuntime {
  late final String _codePath;

  DynamicLocalReactiveRuntime({
    required this._codePath,
    required super.storage,
    required super.discoveryStore,
    required super.log,
  });

  @override
  void loadModule(String name) {
    if (!isModuleRegistered(runtime.registry, name)) {
      loadModuleFromFile(
        name: name,
        path: p.setExtension(
          p.joinAll([_codePath, ...name.split('.')]),
          '.glue',
        ),
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
