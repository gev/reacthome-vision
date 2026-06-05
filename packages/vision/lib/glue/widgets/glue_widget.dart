import 'package:flutter/material.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/glue/logger.dart';

class GlueWidget extends StatefulWidget {
  final Ir expression;
  final Runtime runtime;
  final Logger log;

  const GlueWidget({
    required this.expression,
    required this.runtime,
    required this.log,
    super.key,
  });

  @override
  State<GlueWidget> createState() => _GlueWidgetState();
}

class _GlueWidgetState extends State<GlueWidget> {
  Widget _cachedWidget = const SizedBox.shrink();

  // Tracks execution sequence to prevent async race conditions
  int _currentExecutionId = 0;

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedexpression;

  @override
  void initState() {
    super.initState();
    _executeEvaluation(widget.expression);
  }

  @override
  void didUpdateWidget(GlueWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _executeEvaluation(widget.expression);
  }

  void _executeEvaluation(Ir expression) async {
    // Guard against duplicate executions
    if (_lastEvaluatedexpression == expression) return;

    _lastEvaluatedexpression = expression;

    // final scope = VisionScope.of(context);

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final evaluation = eval(expression);
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
            widget.log.error('$expression \n Widget required');
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
