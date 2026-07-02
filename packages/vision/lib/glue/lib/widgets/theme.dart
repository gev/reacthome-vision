import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir theme = IrEvaluable(() {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    return Eval.pure(
      context != null ? themeData(Theme.of(context)) : IrObject({}),
    );
  });
});

IrNativeValue themeData(ThemeData data) {
  final props = {"color-scheme": colorScheme(data.colorScheme)};
  return IrNativeValue(Value(data, getters: makeGetters(props)));
}

IrNativeValue colorScheme(ColorScheme cs) {
  final props = {
    // Primary colors
    "primary": cs.primary,
    "on-primary": cs.onPrimary,
    "primary-container": cs.primaryContainer,
    "on-primary-container": cs.onPrimaryContainer,

    // Secondary colors
    "secondary": cs.secondary,
    "on-secondary": cs.onSecondary,
    "secondary-container": cs.secondaryContainer,
    "on-secondary-container": cs.onSecondaryContainer,

    // Tertiary colors
    "tertiary": cs.tertiary,
    "on-tertiary": cs.onTertiary,
    "tertiary-container": cs.tertiaryContainer,
    "on-tertiary-container": cs.onTertiaryContainer,

    // Surface and background variants
    "surface": cs.surface,
    "on-surface": cs.onSurface,
    "surface-dim": cs.surfaceDim,
    "surface-bright": cs.surfaceBright,
    "surface-container-lowest": cs.surfaceContainerLowest,
    "surface-container-low": cs.surfaceContainerLow,
    "surface-container": cs.surfaceContainer,
    "surface-container-high": cs.surfaceContainerHigh,
    "surface-container-highest": cs.surfaceContainerHighest,
    "on-surface-variant": cs.onSurfaceVariant,

    // Error colors
    "error": cs.error,
    "on-error": cs.onError,
    "error-container": cs.errorContainer,
    "on-error-container": cs.onErrorContainer,

    // Outlines, shadows, and overlays
    "outline": cs.outline,
    "outline-variant": cs.outlineVariant,
    "shadow": cs.shadow,
    "scrim": cs.scrim,
  };

  return IrNativeValue(Value(cs, getters: makeGetters(props)));
}

Map<String, Eval<Ir>> makeGetters(Map<String, dynamic> props) =>
    props.map((key, value) => MapEntry(key, Eval.pure(toIr(value))));

Ir toIr(dynamic value) => switch (value) {
  bool value => IrBool(value),
  int value => IrInteger(value),
  double value => IrFloat(value),
  Iterable values => IrList(values.map(toIr).toList()),
  IrNativeValue value => value,
  _ => IrNativeValue(Value(value)),
};
