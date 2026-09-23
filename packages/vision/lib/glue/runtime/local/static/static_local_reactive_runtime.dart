import 'package:flutter/services.dart' show rootBundle;
import 'package:glue/compile.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/parse.dart';
import 'package:path/path.dart' as p;
import 'package:vision/glue/runtime/local/local_reactive_runtime.dart';

class StaticLocalReactiveRuntime extends LocalReactiveRuntime {
  final String _package;

  StaticLocalReactiveRuntime({
    required this._package,
    required super.storage,
    required super.discoveryStore,
    required super.log,
  });

  @override
  void loadModule(String name) {
    if (!isModuleRegistered(runtime.registry, name)) {
      final path = p.posix.setExtension(
        p.posix.joinAll(['packages', _package, ...name.split('.')]),
        '.glue',
      );

      _loadModuleFromAsset(name: name, path: path);
    }
  }

  void _loadModuleFromAsset({required String name, required String path}) {
    rootBundle
        .loadString(path)
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
