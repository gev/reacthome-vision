import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:vision/logger.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';
import 'package:vision/mode/local/local_logger.dart';
import 'package:watcher/watcher.dart';

class LocalOrchestrator {
  final String _path;

  late final Logger log;
  late final LocalReactiveRuntime reactiveRuntime;
  late final StreamSubscription<WatchEvent> _subscription;

  LocalOrchestrator({required this._path}) {
    log = LocalLogger();
    reactiveRuntime = LocalReactiveRuntime(path: _path, log: log);
    final watcher = DirectoryWatcher(_path);
    _subscription = watcher.events.listen(_watch);
  }

  void _watch(WatchEvent event) {
    if (event.type == .MODIFY) {
      final relativePath = p.relative(event.path, from: _path);
      final pathWithoutExt = p.withoutExtension(relativePath);
      final name = pathWithoutExt.replaceAll(p.separator, '.');
      reactiveRuntime.loadModuleFromFile(name: name, path: event.path);
    }
  }

  void dispose() {
    _subscription.cancel();
    reactiveRuntime.dispose();
  }
}
