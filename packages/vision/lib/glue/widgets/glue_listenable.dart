import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';

class GlueListenable extends StatefulWidget {
  final List<ValueNotifier> notifiers;
  final Ir lambda;

  const GlueListenable({
    required this.notifiers,
    required this.lambda,
    super.key,
  });

  @override
  State<GlueListenable> createState() => _GlueListenableState();
}

class _GlueListenableState extends State<GlueListenable> {
  Widget _cachedWidget = const SizedBox.shrink();

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedLambda;
  List _lastEvaluatedValues = [];

  late final Scope _scope;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    for (final notifier in widget.notifiers) {
      notifier.addListener(_runGuarded);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _scope = Scope.of(context);
      _scope.reactiveRuntime.addListener(_run);
    }
    _run();
  }

  @override
  void didUpdateWidget(GlueListenable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Manage notifier subscription lifecycle
    if (oldWidget.notifiers != widget.notifiers) {
      for (final notifier in oldWidget.notifiers) {
        notifier.removeListener(_runGuarded);
      }
      for (final notifier in widget.notifiers) {
        notifier.addListener(_runGuarded);
      }
    }
    // Trigger re-evaluation
    _runGuarded();
  }

  void _runGuarded() {
    // Guard against duplicate executions
    if (_lastEvaluatedLambda == widget.lambda &&
        listEquals(_lastEvaluatedValues, _values)) {
      return;
    }
    _run();
  }

  List get _values =>
      widget.notifiers.map((notifier) => notifier.value).toList();

  Ir _toIr(ValueNotifier notifier) => toIr(notifier.value);

  void _run() {
    _lastEvaluatedLambda = widget.lambda;
    _lastEvaluatedValues = _values;

    final evaluation = apply(
      widget.lambda,
      widget.notifiers.map(_toIr).toList(),
    );
    final result = runEval(
      evaluation,
      _scope.reactiveRuntime.runtime.copyWith(
        context: putToContext<BuildContext>(
          _scope.reactiveRuntime.runtime.context,
          context,
        ),
      ),
    );

    result.match(
      (err) {
        _scope.log.error(err);
      },
      (res) {
        if (mounted) {
          final (val, _) = res;
          final newWidget = extractLast(val);
          if (newWidget == null) {
            _scope.log.error('Widget required');
          } else {
            setState(() {
              _cachedWidget = newWidget;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _cachedWidget;
  }

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_run);
    for (final notifier in widget.notifiers) {
      notifier.removeListener(_runGuarded);
    }
    super.dispose();
  }
}
