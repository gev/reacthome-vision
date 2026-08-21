import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';

final Ir seedColorScheme = IrNativeFunc(_seedColorSchemeImpl);

Eval<Ir> _seedColorSchemeImpl(Ir ir) {
  switch (ir) {
    case IrObject obj:
      final properties = WidgetProperties(obj.properties.unlock);
      final seedColor = properties.getColor('seed-color');
      if (seedColor == null) {
        return throwError(
          wrongArgumentType(['Color `seed-color` property required']),
        );
      }
      final colorScheme = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness:
            properties.getValue<Brightness>('brightness') ?? Brightness.light,
        dynamicSchemeVariant:
            properties.getValue<DynamicSchemeVariant>(
              'dynamic-scheme-variant',
            ) ??
            DynamicSchemeVariant.tonalSpot,
      );

      return Eval.pure(IrNativeValue(Value(colorScheme)));

    default:
      return throwError(wrongArgumentType(['Required property: seed-color']));
  }
}
