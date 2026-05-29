import 'package:flutter/material.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/glue/logger.dart';

class GlueListenable extends StatefulWidget {
  final ValueNotifier<Ir> notifier;
  final Ir lambda;
  final Runtime runtime;
  final Logger log;

  const GlueListenable({
    required this.notifier,
    required this.lambda,
    required this.runtime,
    required this.log,
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
    _executeEvaluation(widget.lambda, widget.notifier.value);
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

    final evaluation = eval(value).flatMap((val) => apply(lambda, [val]));
    final result = await runEval(evaluation, widget.runtime);

    if (executionId != _currentExecutionId) return;

    result.match(
      (err) {
        widget.log.error(err);
      },
      (res) {
        if (mounted) {
          final (val, _) = res;
          final newWidget = extractWidget(val);
          if (newWidget == null) {
            widget.log.error('$value \n Widget required');
          } else {
            setState(() => _cachedWidget = newWidget);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.notifier.value);
    print(_cachedWidget);
    print(widget.runtime);
    print("");
    return _cachedWidget;
  }
}
