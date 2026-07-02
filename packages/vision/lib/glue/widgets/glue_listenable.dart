import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';

class GlueListenable extends StatefulWidget {
  final ValueNotifier<Ir> notifier;
  final Ir lambda;
  final Env? env;

  const GlueListenable({
    required this.notifier,
    required this.lambda,
    this.env,
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

  late final Scope _scope;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_runGuarded);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    _scope = Scope.of(context);
    _run();
  }

  @override
  void didUpdateWidget(GlueListenable oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Manage notifier subscription lifecycle
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(_runGuarded);
      widget.notifier.addListener(_runGuarded);
    }
    // Trigger re-evaluation
    _runGuarded();
  }

  void _runGuarded() async {
    // Guard against duplicate executions
    if (_lastEvaluatedLambda == widget.lambda &&
        _lastEvaluatedValue == widget.notifier.value) {
      return;
    }
    _run();
  }

  void _run() async {
    _lastEvaluatedLambda = widget.lambda;
    _lastEvaluatedValue = widget.notifier.value;

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final evaluation = apply(widget.lambda, [widget.notifier.value]);
    final result = await runEval(
      evaluation,
      _scope.reactiveRuntime.runtime.copyWith(
        env: widget.env,
        context: putToContext<BuildContext>(
          _scope.reactiveRuntime.runtime.context,
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
          final newWidget = extractLast(val);
          if (newWidget == null) {
            _scope.log.error('${widget.notifier.value} \n Widget required');
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
    widget.notifier.removeListener(_runGuarded);
    super.dispose();
  }
}
