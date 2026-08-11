import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

/// Creates a Theme widget as a special form,
/// evaluating data before and child lazily inside the correct context.
final Ir withTheme = IrSpecial(withThemeImpl);

Eval<Ir> withThemeImpl(List<Ir> ir) {
  return getRuntime().bind((runtime) {
    switch (ir) {
      case [IrObject(:final properties)]
          when properties.containsKey('data') &&
              properties.containsKey('child'):
        final dataIr = properties['data']!;
        final childIr = properties['child']!;
        final key = properties['key'];

        final dataRes = runEval(eval(dataIr), runtime);
        return dataRes.match(
          (err) {
            return throwError(
              wrongArgumentType(['Property `data` should be ThemeData']),
            );
          },
          (val) {
            final themeData = to<ThemeData>(val.$1);
            if (themeData == null) {
              return throwError(
                wrongArgumentType(['Property `data` should be ThemeData']),
              );
            }
            return Eval.pure(
              IrNativeValue(
                Value(
                  _ThemeSpecialWidget(
                    key: key != null ? ValueKey(key) : null,
                    themeData: themeData,
                    childIr: childIr,
                    env: runtime.env,
                  ),
                ),
              ),
            );
          },
        );
      default:
        return throwError(
          wrongArgumentType(['Required theme properties: data and child']),
        );
    }
  });
}

class _ThemeSpecialWidget extends StatelessWidget {
  final ThemeData themeData;
  final Ir childIr;
  final Env env;

  const _ThemeSpecialWidget({
    required this.themeData,
    required this.childIr,
    required this.env,
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData,
      child: GlueWidget(expression: childIr, env: env),
    );
  }
}
