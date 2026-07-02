import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

class GlueCanvas extends StatelessWidget {
  final Iterable<CanvasHandler> foreground;
  final Iterable<CanvasHandler> background;
  final Env env;
  final Size size;
  final Widget? child;

  GlueCanvas({
    this.foreground = const [],
    this.background = const [],
    this.child,
    required this.env,
    super.key,
    double? width,
    double? height,
  }) : size = Size(width ?? 0, height ?? 0);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      foregroundPainter: _Painter(foreground),
      painter: _Painter(background),
      child: child,
    );
  }
}

class _Painter extends CustomPainter {
  Iterable<CanvasHandler> handlers;

  _Painter(this.handlers);

  @override
  void paint(Canvas canvas, Size size) {
    for (final handle in handlers) {
      handle(canvas);
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return handlers != oldDelegate.handlers;
  }
}
