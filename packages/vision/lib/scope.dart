import 'package:flutter/widgets.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';
import 'package:vision/session/session_monitor.dart';

class Scope extends InheritedWidget {
  final Logger log;
  final ReactiveRuntime reactiveRuntime;
  final SessionMonitor session;

  const Scope({
    required this.log,
    required this.reactiveRuntime,
    required this.session,
    required super.child,
    super.key,
  });

  static Scope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<Scope>();
    assert(scope != null, 'No Scope found in the context');
    return scope!;
  }

  @override
  bool updateShouldNotify(Scope oldWidget) =>
      log != oldWidget.log ||
      reactiveRuntime != oldWidget.reactiveRuntime ||
      session != oldWidget.session;
}
