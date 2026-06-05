import 'package:flutter/material.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';

class GlueListenable extends StatefulWidget {
  final ValueNotifier<Ir> notifier;
  final Ir lambda;

  const GlueListenable({
    required this.notifier,
    required this.lambda,
    super.key,
  });

  @override
  State<GlueListenable> createState() => _GlueListenableState();
}

class _GlueListenableState extends State<GlueListenable> {
  Widget _cachedWidget = const SizedBox.shrink();

  // Tracks execution sequence to prevent async race conditions
  int _currentExecutionId = 0;

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedLambda;
  Ir? _lastEvaluatedValue;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_onNotifierTick);
  }

  @override
  void didUpdateWidget(GlueListenable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Manage notifier subscription lifecycle
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(_onNotifierTick);
      widget.notifier.addListener(_onNotifierTick);
    }
    // Trigger re-evaluation
    _executeEvaluation(widget.lambda, widget.notifier.value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _executeEvaluation(widget.lambda, widget.notifier.value);
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onNotifierTick);
    super.dispose();
  }

  void _onNotifierTick() {
    _executeEvaluation(widget.lambda, widget.notifier.value);
  }

  void _executeEvaluation(Ir lambda, Ir value) async {
    // Guard against duplicate executions
    if (_lastEvaluatedLambda == lambda && _lastEvaluatedValue == value) return;

    _lastEvaluatedLambda = lambda;
    _lastEvaluatedValue = value;

    // final scope = VisionScope.of(context);

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final scope = Scope.of(context);
    final evaluation = eval(value).flatMap((val) => apply(lambda, [val]));
    final result = await runEval(evaluation, scope.runtime);

    if (executionId != _currentExecutionId) return;

    result.match(
      (err) {
        scope.log.error(err);
      },
      (res) {
        if (mounted) {
          final (val, _) = res;
          final newWidget = extractWidget(val);
          if (newWidget == null) {
            scope.log.error('$value \n Widget required');
          } else {
            setState(() => _cachedWidget = newWidget);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _cachedWidget;
  }
}
