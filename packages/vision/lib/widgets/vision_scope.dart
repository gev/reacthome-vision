import 'package:flutter/widgets.dart';
import 'package:vision/scope.dart';

class VisionScope extends InheritedWidget {
  final Scope scope;

  const VisionScope({required this.scope, required super.child, super.key});

  static Scope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<VisionScope>();
    assert(scope != null, 'No VisionScope found in context');
    return scope!.scope;
  }

  @override
  bool updateShouldNotify(VisionScope oldWidget) {
    return scope != oldWidget.scope;
  }
}
