import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glue/either.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

final Ir overlayRoute = IrSpecial(overlayRouteImpl);

Eval<Ir> overlayRouteImpl(List<Ir> ir) => getRuntime().bind((runtime) {
  switch (ir) {
    case [IrObject(:final properties)]:
      final screen = properties['screen'];
      if (screen == null) {
        return throwError(wrongArgumentType(['`screen` propery required']));
      }

      final props = runEval(
        eval(IrObject(properties.remove('screen').unlock)),
        runtime,
      );

      return props.match((err) => Eval((_) => Left(err)), (success) {
        switch (success) {
          case (IrObject(:final properties), _):
            final tag = properties['tag'];
            if (tag == null) {
              return throwError(wrongArgumentType(['Hero `tag` required']));
            }
            return Eval.pure(
              IrNativeValue(
                Value(
                  makeOverlayRouteBuilder(
                    key: GlobalKey(),
                    tag: tag,
                    screen: screen,
                    background: to<Color>(properties['background']),
                    borderRadius: toDouble(properties['border-radius']) ?? 12,
                    opacity: toDouble(properties['opacity']) ?? 1,
                    blur: toDouble(properties['blur']) ?? 50,
                    duration: Duration(
                      milliseconds: toInt(properties['duration']) ?? 300,
                    ),
                    env: runtime.env,
                  ),
                ),
              ),
            );
          default:
            return throwError(
              wrongArgumentType(['Properties` oject required']),
            );
        }
      });

    default:
      return throwError(wrongArgumentType(['Route `Object` required']));
  }
});

Route<Ir> makeOverlayRouteBuilder({
  required Key key,
  required Object tag,
  required Ir screen,
  Color? background,
  required double borderRadius,
  required double opacity,
  required double blur,
  required Duration duration,
  required Env env,
}) => PageRouteBuilder(
  opaque: false,
  pageBuilder: (context, animation, secondaryAnimation) {
    var isClosing = false;
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    final backgroundColor = background ?? theme.colorScheme.surface;
    final content = Material(
      key: key,
      type: MaterialType.transparency,
      child: Card(
        color: backgroundColor.withValues(alpha: opacity),
        child: FittedBox(
          fit: BoxFit.contain,
          child: GlueWidget(expression: screen, env: env),
        ),
      ),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        isClosing = true;
        navigator.pop();
      },
      onVerticalDragUpdate: (details) {
        if (!isClosing && details.delta.dy.abs() > 10) {
          isClosing = true;
          navigator.pop();
        }
      },
      child: Center(
        child: Hero(
          tag: tag,
          flightShuttleBuilder:
              (flightContext, animation, direction, fromContext, toContext) {
                final isPush = direction == HeroFlightDirection.push;
                return isPush ? toContext.widget : fromContext.widget;
              },
          child: content,
        ),
      ),
    );
  },
  transitionDuration: duration,
  reverseTransitionDuration: duration,
);
