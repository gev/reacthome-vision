import 'dart:io';

import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/local/glue/local_logger.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';

class FileOrchestrator {
  late final Logger log;
  late final ReactiveRuntime reactiveRuntime;

  FileOrchestrator({required Directory path}) {
    log = LocalLogger();
    reactiveRuntime = LocalReactiveRuntime(log: log);
  }

  void dispose() {
    reactiveRuntime.dispose();
  }
}
