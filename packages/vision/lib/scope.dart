import 'package:flutter/widgets.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/session/session_monitor.dart';

class Scope extends InheritedWidget {
  final Logger log;
  final Runtime runtime;
  final SessionMonitor session;

  const Scope({
    required this.log,
    required this.runtime,
    required this.session,
    required super.child,
    super.key,
  });

  static Scope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<Scope>();
    assert(scope != null, 'No VisionScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(Scope oldWidget) =>
      log != oldWidget.log ||
      runtime != oldWidget.runtime ||
      session != oldWidget.session;
}
