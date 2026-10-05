import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/glue/runtime/scope.dart';

class GlueLayout extends StatefulWidget {
  final Ir expression;

  const GlueLayout({required this.expression, super.key});

  @override
  State<GlueLayout> createState() => _GlueLayoutState();
}

class _GlueLayoutState extends State<GlueLayout> {
  Widget _cachedWidget = const SizedBox.shrink();

  late final Scope _scope;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _scope = Scope.of(context);
      _scope.reactiveRuntime.addListener(_forceRebuild);
    }
    _forceRebuild();
  }

  @override
  void didUpdateWidget(GlueLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expression != widget.expression) {
      _forceRebuild();
    }
  }

  void _forceRebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final irConstraints = IrObject({
        'width': toIr(constraints.maxWidth),
        'min-width': toIr(constraints.minWidth),
        'max-width': toIr(constraints.maxWidth),
        'has-bounded-width': toIr(constraints.hasBoundedWidth),
        'has-infinite-width': toIr(constraints.hasInfiniteWidth),
        'has-tight-width': toIr(constraints.hasTightWidth),

        'height': toIr(constraints.maxHeight),
        'min-height': toIr(constraints.minHeight),
        'max-height': toIr(constraints.maxHeight),
        'has-bounded-height': toIr(constraints.hasBoundedHeight),
        'has-infinite-height': toIr(constraints.hasInfiniteHeight),
        'has-tight-height': toIr(constraints.hasTightHeight),

        'is-tight': toIr(constraints.isTight),
        'shortest-side': toIr(constraints.biggest.shortestSide),
      });

      final evaluation = apply(widget.expression, [irConstraints]);
      final result = runEval(
        evaluation,
        _scope.reactiveRuntime.runtime.copyWith(
          context: putToContext<BuildContext>(
            _scope.reactiveRuntime.runtime.context,
            context,
          ),
        ),
      );

      switch (result) {
        case Left(value: final err):
          _scope.log.error(err);
          return _cachedWidget;
        case Right(value: final val):
          final newWidget = extractLast<Widget>(val.$1);
          if (newWidget == null) {
            _scope.log.error('${widget.expression} \n Widget required');
            return _cachedWidget;
          } else {
            return newWidget;
          }
      }
    },
  );

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_forceRebuild);
    super.dispose();
  }
}
