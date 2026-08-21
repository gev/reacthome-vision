import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

final Ir withSeedColor = IrSpecial(withSeedColorImpl);

Eval<Ir> withSeedColorImpl(List<Ir> ir) {
  return getRuntime().bind((runtime) {
    switch (ir) {
      case [IrObject(:final properties)]
          when properties.containsKey('seed-color') &&
              properties.containsKey('child'):
        final seed = properties['seed-color']!;
        final dynamicSchemeVariant =
            properties['dynamic-scheme-variant'] ?? IrVoid();
        final childIr = properties['child']!;
        final key = properties['key'];
        final dataRes = runEval(
          sequence(eval(seed), eval(dynamicSchemeVariant)),
          runtime,
        );
        return dataRes.match(
          (err) {
            return throwError(
              wrongArgumentType(['Property `seed-color` should be Color']),
            );
          },
          (val) {
            final ((seedIr, dynamicSchemeVariantIr), _) = val;
            final seed = extr(seedIr);
            if (seed == null) {
              return throwError(
                wrongArgumentType(['Property `seed-color` should be Color']),
              );
            }
            final dynamicSchemeVariant =
                to<DynamicSchemeVariant>(dynamicSchemeVariantIr) ??
                DynamicSchemeVariant.tonalSpot;
            return Eval.pure(
              IrNativeValue(
                Value(
                  _PaletteSpecialWidget(
                    key: key != null ? ValueKey(key) : null,
                    seedColor: seed,
                    dynamicSchemeVariant: dynamicSchemeVariant,
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
          wrongArgumentType(['Required Palette properties: data and child']),
        );
    }
  });
}

class _PaletteSpecialWidget extends StatelessWidget {
  final Color seedColor;
  final DynamicSchemeVariant dynamicSchemeVariant;
  final Ir childIr;
  final Env env;

  const _PaletteSpecialWidget({
    required this.seedColor,
    required this.dynamicSchemeVariant,
    required this.childIr,
    required this.env,
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          dynamicSchemeVariant: dynamicSchemeVariant,
          brightness: theme.brightness,
        ),
        textTheme: theme.textTheme,
      ),
      child: GlueWidget(expression: childIr, env: env),
    );
  }
}
