import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
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
  Runtime? _lastEvalatedRuntime;
  Ir? _lastEvaluatedLambda;
  Ir? _lastEvaluatedValue;

  late final Scope _scope;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_executeEvaluation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scope = Scope.of(context);
    _scope.runtime.addListener(_executeEvaluation);
    _executeEvaluation();
  }

  @override
  void didUpdateWidget(GlueListenable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Manage notifier subscription lifecycle
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(_executeEvaluation);
      widget.notifier.addListener(_executeEvaluation);
    }
    // Trigger re-evaluation
    _executeEvaluation();
  }

  void _executeEvaluation() async {
    // Guard against duplicate executions
    if (_lastEvaluatedLambda == widget.lambda &&
        _lastEvaluatedValue == widget.notifier.value &&
        _lastEvalatedRuntime == _scope.runtime.actual) {
      return;
    }

    _lastEvalatedRuntime = _scope.runtime.actual;
    _lastEvaluatedLambda = widget.lambda;
    _lastEvaluatedValue = widget.notifier.value;

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final evaluation = eval(
      widget.notifier.value,
    ).flatMap((val) => apply(widget.lambda, [val]));
    final result = await runEval(
      evaluation,
      _scope.runtime.actual.copyWith(
        context: putToContext<BuildContext>(
          _scope.runtime.actual.context,
          context,
        ),
      ),
    );

    if (executionId != _currentExecutionId) return;

    result.match(
      (err) {
        _scope.log.error(err);
      },
      (res) {
        if (mounted) {
          final (val, _) = res;
          final newWidget = extractWidget(val);
          if (newWidget == null) {
            _scope.log.error('${widget.notifier.value} \n Widget required');
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

  @override
  void dispose() {
    _scope.runtime.removeListener(_executeEvaluation);
    widget.notifier.removeListener(_executeEvaluation);
    super.dispose();
  }
}
