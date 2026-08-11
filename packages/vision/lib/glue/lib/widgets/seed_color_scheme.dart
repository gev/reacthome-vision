import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir seedColorScheme = IrNativeFunc(_seedColorSchemeImpl);

Eval<Ir> _seedColorSchemeImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final seedColor = to<Color>(properties['seed']);
      if (seedColor == null) {
        return throwError(
          wrongArgumentType(['Color `seed` property required']),
        );
      }

      final colorScheme = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness:
            to<Brightness>(properties['brightness']) ?? Brightness.light,
        dynamicSchemeVariant:
            to<DynamicSchemeVariant>(properties['dynamic-scheme-variant']) ??
            DynamicSchemeVariant.tonalSpot,
      );

      return Eval.pure(IrNativeValue(Value(colorScheme)));

    default:
      return throwError(wrongArgumentType(['Required property: seed']));
  }
}
