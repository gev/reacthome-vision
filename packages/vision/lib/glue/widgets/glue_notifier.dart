import 'package:flutter/foundation.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';

class GlueNotifier extends ValueNotifier<dynamic> {
  final List<ValueNotifier> notifiers;
  final Ir lambda;
  final ReactiveRuntime reactiveRuntime;
  final Logger log;

  List _lastEvaluatedValues = [];

  GlueNotifier({
    required this.notifiers,
    required this.lambda,
    required this.reactiveRuntime,
    required this.log,
  }) : super(null) {
    for (final notifier in notifiers) {
      notifier.addListener(_runGuarded);
    }
    reactiveRuntime.addListener(_run);
    _run();
  }

  List get _values => notifiers.map((notifier) => notifier.value).toList();

  Ir _toIr(ValueNotifier notifier) => toIr(notifier.value);

  void _runGuarded() {
    if (listEquals(_lastEvaluatedValues, _values)) {
      return;
    }
    _run();
  }

  void _run() {
    _lastEvaluatedValues = _values;
    final evaluation = apply(lambda, notifiers.map(_toIr).toList());
    final result = runEval(evaluation, reactiveRuntime.runtime);
    result.match(
      (err) {
        log.error(err);
      },
      (res) {
        final (val, _) = res;
        value = val;
      },
    );
  }

  @override
  void dispose() {
    reactiveRuntime.removeListener(_run);
    for (final notifier in notifiers) {
      notifier.removeListener(_runGuarded);
    }
    super.dispose();
  }
}
