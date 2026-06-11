import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';

class GlueWidget extends StatefulWidget {
  final Ir expression;
  final Env env;

  GlueWidget({required this.expression, Env? env, super.key})
    : env = env ?? emptyEnv();

  @override
  State<GlueWidget> createState() => _GlueWidgetState();
}

class _GlueWidgetState extends State<GlueWidget> {
  Widget _cachedWidget = const SizedBox.shrink();

  // Tracks execution sequence to prevent async race conditions
  int _currentExecutionId = 0;

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedexpression;

  late final Scope _scope;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scope = Scope.of(context);
    _scope.reactiveRuntime.addListener(_run);
    _run();
  }

  @override
  void didUpdateWidget(GlueWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runGuarded();
  }

  void _runGuarded() async {
    // Guard against duplicate executions
    if (_lastEvaluatedexpression == widget.expression) {
      return;
    }
    _run();
  }

  void _run() async {
    _lastEvaluatedexpression = widget.expression;

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final evaluation = eval(widget.expression);
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
          final newWidget = extractLast<Widget>(val);
          if (newWidget == null) {
            _scope.log.error('${widget.expression} \n Widget required');
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
    super.dispose();
  }
}
