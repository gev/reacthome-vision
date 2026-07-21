import 'dart:io';

import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/local/glue/local_logger.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';

class FileOrchestrator {
  final String _path;

  late final Logger log;
  late final ReactiveRuntime reactiveRuntime;

  FileOrchestrator({required this._path}) {
    log = LocalLogger();
    reactiveRuntime = LocalReactiveRuntime(path: _path, log: log);
  }

  void dispose() {
    reactiveRuntime.dispose();
  }
}
