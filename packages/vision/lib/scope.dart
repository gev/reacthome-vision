import 'package:flutter/widgets.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/session/session_monitor.dart';
import 'package:vision/session/session_orchestrator.dart';

class Scope extends InheritedWidget {
  final SessionOrchestrator _orchestrator;

  const Scope({required this._orchestrator, required super.child, super.key});

  Logger get log => _orchestrator.log;
  SessionMonitor get session => _orchestrator.monitor;
  GlueEvaluator get evaluator => _orchestrator.evaluator;

  static Scope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<Scope>();
    assert(scope != null, 'No VisionScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(Scope oldWidget) {
    return _orchestrator != oldWidget._orchestrator;
  }
}
