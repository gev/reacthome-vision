import 'dart:io';

import 'package:glue/compile.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/parse.dart';
import 'package:path/path.dart' as p;
import 'package:vision/glue/runtime/local/local_reactive_runtime.dart';
import 'package:vision/glue/runtime/reactive_runtime.dart';

class DynamicLocalReactiveRuntime extends LocalReactiveRuntime {
  late final String _codePath;

  DynamicLocalReactiveRuntime({
    required this._codePath,
    required super.storage,
    required super.discoveryStore,
    required super.log,
  });

  @override
  Future<Iterable<ModuleExpr>> preloadModules() async {
    final modules = <ModuleExpr>[];
    try {
      final files = Directory(_codePath)
          .list(recursive: true, followLinks: false);
      await for (final entity in files) {
        if (entity is File && p.extension(entity.path) == '.glue') {
          final name = _moduleNameForPath(entity.path);
          final module = await _readModuleFromFile(
            name: name,
            path: entity.path,
          );
          if (module != null) {
            modules.add(module);
          }
        }
      }
    } catch (error) {
      log.error('Failed to scan module directory $_codePath: $error');
    }
    return modules;
  }

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
    _readModuleFromFile(name: name, path: path).then((module) {
      if (module != null) {
        tryRegisterModule(module);
      }
    });
  }

  String _moduleNameForPath(String path) {
    final relativePath = p.relative(path, from: _codePath);
    return p.withoutExtension(relativePath).split(p.separator).join('.');
  }

  Future<ModuleExpr?> _readModuleFromFile({
    required String name,
    required String path,
  }) async {
    final file = File(path);
    try {
      final glue = await file.readAsString();
      return await parseGlue(glue).match((error) {
        log.error(error.message);
        return null;
      }, (ast) => (name: name, expr: compile(ast)));
    } catch (error) {
      log.error('Failed to load module $name: $error');
      return null;
    }
  }
}
