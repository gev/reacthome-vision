import 'package:flutter/foundation.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';

class GlueNotifier extends ValueNotifier<dynamic> {
  final Ir _lambda;
  final List<ValueNotifier> _notifiers;
  final bool _isList;
  final ReactiveRuntime _reactiveRuntime;
  final Logger _log;

  List _lastEvaluatedValues = [];

  GlueNotifier({
    required this._lambda,
    required this._notifiers,
    required this._isList,
    required this._reactiveRuntime,
    required this._log,
  }) : super(null) {
    for (final notifier in _notifiers) {
      notifier.addListener(_runGuarded);
    }
    _reactiveRuntime.addListener(_run);
    _run();
  }

  List get _values => _notifiers.map((notifier) => notifier.value).toList();

  Ir _toIr(ValueNotifier notifier) => toIr(notifier.value);

  void _runGuarded() {
    if (listEquals(_lastEvaluatedValues, _values)) {
      return;
    }
    _run();
  }

  void _run() {
    _lastEvaluatedValues = _values;
    final notifiers = _notifiers.map(_toIr).toList();
    final evaluation = apply(
      _lambda,
      _isList ? [IrList(notifiers)] : notifiers,
    );
    final result = runEval(evaluation, _reactiveRuntime.runtime);
    result.match(
      (err) {
        _log.error(err);
      },
      (res) {
        final (val, _) = res;
        value = val;
      },
    );
  }

  @override
  void dispose() {
    _reactiveRuntime.removeListener(_run);
    for (final notifier in _notifiers) {
      notifier.removeListener(_runGuarded);
    }
    super.dispose();
  }
}
