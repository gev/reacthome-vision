import 'package:flutter/services.dart' show AssetManifest, rootBundle;
import 'package:glue/compile.dart';
import 'package:glue/module/registry.dart';
import 'package:glue/parse.dart';
import 'package:path/path.dart' as p;
import 'package:vision/glue/runtime/local/local_reactive_runtime.dart';
import 'package:vision/glue/runtime/reactive_runtime.dart';

class StaticLocalReactiveRuntime extends LocalReactiveRuntime {
  final String _package;

  StaticLocalReactiveRuntime({
    required this._package,
    required super.storage,
    required super.discoveryStore,
    required super.log,
  });

  @override
  Future<Iterable<ModuleExpr>> preloadModules() async {
    final modules = <ModuleExpr>[];
    final assetRoot = p.posix.join('packages', _package, 'glue');
    final assetPrefix = '$assetRoot/';

    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      for (final asset in manifest.listAssets()) {
        if (asset.startsWith(assetPrefix) &&
            p.posix.extension(asset) == '.glue') {
          final name = p.posix.withoutExtension(
            asset.substring(assetPrefix.length),
          );
          final module = await _readModuleFromAsset(name: name, path: asset);
          if (module != null) {
            modules.add(module);
          }
        }
      }
    } catch (error) {
      log.error('Failed to preload modules from $assetRoot: $error');
    }

    return modules;
  }

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
    _readModuleFromAsset(name: name, path: path).then((module) {
      if (module != null) {
        tryRegisterModule(module);
      }
    });
  }

  Future<ModuleExpr?> _readModuleFromAsset({
    required String name,
    required String path,
  }) async {
    try {
      final glue = await rootBundle.loadString(path);
      return await parseGlue(glue).match((error) {
        log.error(error.message);
        return null;
      }, (ast) => (name: name, expr: compile(ast)));
    } catch (error) {
      log.error('Failed to load module $name from $path: $error');
      return null;
    }
  }
}
