import 'package:flutter/widgets.dart';
import 'package:vision/glue/logger.dart';

import 'glue/reactive_runtime.dart';

class Scope extends InheritedWidget {
  final Logger log;
  final ReactiveRuntime reactiveRuntime;

  const Scope({
    required this.log,
    required this.reactiveRuntime,
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
      log != oldWidget.log || reactiveRuntime != oldWidget.reactiveRuntime;
}
