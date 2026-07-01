import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/glue/lib/canvas/handler.dart';
import 'package:vision/scope.dart';

class GlueCanvas extends StatefulWidget {
  final Ir? foreground;
  final Ir? background;
  final Env env;
  final Size size;
  final Widget? child;

  GlueCanvas({
    this.foreground,
    this.background,
    this.child,
    required this.env,
    super.key,
    double? width,
    double? height,
  }) : size = Size(width ?? 0, height ?? 0);

  @override
  State<GlueCanvas> createState() => _GlueCanvasState();
}

class _GlueCanvasState extends State<GlueCanvas> {
  CanvasHandler? _cachedCanvasHandler;

  // Tracks execution sequence to prevent async race conditions
  int _currentExecutionId = 0;

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedExpression;

  late final Scope _scope;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    _scope = Scope.of(context);
    _scope.reactiveRuntime.addListener(_run);
    _run();
  }

  @override
  void didUpdateWidget(GlueCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runGuarded();
  }

  void _runGuarded() async {
    // Guard against duplicate executions
    if (_lastEvaluatedExpression == widget.foreground) {
      return;
    }
    _run();
  }

  void _run() async {
    final expression = widget.foreground;
    if (expression == null) return;

    _lastEvaluatedExpression = widget.foreground;

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final evaluation = eval(expression);
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
          final newCanvasHandler = extractLast<CanvasHandler>(val);
          if (newCanvasHandler == null) {
            _scope.log.error('${widget.foreground} \n Widget required');
          } else {
            setState(() {
              _cachedCanvasHandler = newCanvasHandler;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: _Painter(_cachedCanvasHandler),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}

class _Painter extends CustomPainter {
  CanvasHandler? handle;

  _Painter(this.handle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = handle;
    if (paint != null) {
      paint(canvas);
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return handle != oldDelegate.handle;
  }
}
