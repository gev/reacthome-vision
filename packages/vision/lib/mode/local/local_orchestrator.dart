import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/logger.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';
import 'package:vision/mode/local/local_logger.dart';
import 'package:vision/mode/local/local_storage.dart';
import 'package:watcher/watcher.dart';

class LocalOrchestrator {
  final String _codePath;

  late final Logger log;
  late final LocalReactiveRuntime reactiveRuntime;
  late final LocalStorage _storage;

  late final StreamSubscription<WatchEvent> _subscription;

  LocalOrchestrator({required Directory path, required this._codePath}) {
    log = LocalLogger();

    _storage = LocalStorage(path: path, log: log);

    reactiveRuntime = LocalReactiveRuntime(
      path: _codePath,
      storage: _storage,
      log: log,
    );
    final watcher = DirectoryWatcher(_codePath);
    _subscription = watcher.events.listen(_watch);
  }

  void _watch(WatchEvent event) {
    if (event.type == .MODIFY) {
      final relativePath = p.relative(event.path, from: _codePath);
      final pathWithoutExt = p.withoutExtension(relativePath);
      final name = pathWithoutExt.replaceAll(p.separator, '.');
      reactiveRuntime.loadModuleFromFile(name: name, path: event.path);
    }
  }

  void dispose() {
    _subscription.cancel();
    reactiveRuntime.dispose();
    _storage.dispose();
  }
}
