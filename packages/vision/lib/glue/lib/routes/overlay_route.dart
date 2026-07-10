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
                    opacity: toDouble(properties['opacity']) ?? 1,
                    elevation: toDouble(properties['elevation']) ?? 24,
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
  required double opacity,
  required double elevation,
  required Duration duration,
  required Env env,
}) => PageRouteBuilder(
  opaque: false,
  pageBuilder: (context, animation, secondaryAnimation) {
    var isClosing = false;
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    final scrimColor = theme.colorScheme.scrim;
    final content = Material(
      key: key,
      type: MaterialType.transparency,
      child: GlueWidget(expression: screen, env: env),
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
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Container(
            color: scrimColor.withValues(alpha: opacity * animation.value),
            child: Center(
              child: Hero(
                tag: tag,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    return Card(
                      elevation: elevation * animation.value,
                      clipBehavior: Clip.antiAlias,
                      color: Colors.transparent,
                      margin: EdgeInsets.zero,
                      child: content,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  },
  transitionDuration: duration,
  reverseTransitionDuration: duration,
);
