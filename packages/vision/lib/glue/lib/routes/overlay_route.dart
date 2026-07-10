import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/route.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

final Ir overlayRoute = IrNativeFunc(overlayRouteImpl);

Eval<Ir> overlayRouteImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final screen = properties['screen'];
      if (screen is! IrClosure) {
        return throwError(
          wrongArgumentType(['`screen` lambda  propery required']),
        );
      }
      final tag = properties['tag'];
      if (tag == null) {
        return throwError(wrongArgumentType(['Hero `tag` required']));
      }
      return getEnv().bind((env) {
        return Eval.pure(
          IrNativeValue(
            Value(
              makeOverlayRouteBuilder(
                key: GlobalKey(),
                tag: tag,
                screen: screen,
                borderRadius: toDouble(properties['border-radius']) ?? 12,
                opacity: toDouble(properties['opacity']) ?? 1,
                blur: toDouble(properties['blur']) ?? 50,
                duration: Duration(
                  milliseconds: toInt(properties['duration']) ?? 300,
                ),
                env: env,
              ),
            ),
          ),
        );
      });
    default:
      return throwError(wrongArgumentType(['Route `Object` required']));
  }
}

RouteBuilder makeOverlayRouteBuilder({
  required Key key,
  required Object tag,
  required Ir screen,
  required double borderRadius,
  required double opacity,
  required double blur,
  required Duration duration,
  required Env env,
}) =>
    (RouteSettings settings) => PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        var isClosing = false;
        final navigator = Navigator.of(context);
        final theme = Theme.of(context);
        final background = theme.colorScheme.surface;
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
          child: Hero(
            tag: tag,
            flightShuttleBuilder:
                (flightContext, animation, direction, fromContext, toContext) {
                  final isPush = direction == HeroFlightDirection.push;

                  final fadeOutWidget = isPush
                      ? fromContext.widget
                      : toContext.widget;

                  final fadeInWidget = isPush
                      ? toContext.widget
                      : fromContext.widget;

                  return Stack(
                    children: [
                      Positioned.fill(
                        child: FadeTransition(
                          opacity: animation.drive(Tween(begin: 1.0, end: 0.0)),
                          child: fadeOutWidget,
                        ),
                      ),
                      Positioned.fill(
                        child: FadeTransition(
                          opacity: animation,
                          child: fadeInWidget,
                        ),
                      ),
                    ],
                  );
                },
            child: AnimatedBuilder(
              key: key,
              animation: animation,
              builder: (context, _) {
                final sigma = blur * animation.value;
                final radius = borderRadius * (1 - animation.value);
                return ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(
                    Radius.circular(radius),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                    child: Material(
                      type: MaterialType.transparency,
                      color: background.withValues(alpha: opacity),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: GlueWidget(
                            expression: IrList([
                              screen,
                              toIr(settings.arguments),
                            ]),
                            env: env,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
