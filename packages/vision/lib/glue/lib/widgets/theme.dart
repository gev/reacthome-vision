import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/widgets/getters.dart';

final Ir theme = IrEvaluable(() {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    return Eval.pure(
      context != null ? themeData(Theme.of(context)) : IrObject({}),
    );
  });
});

IrNativeValue themeData(ThemeData data) {
  final props = {
    "color-scheme": colorScheme(data.colorScheme),
    "text-theme": textTheme(data.textTheme),
  };
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

IrNativeValue textTheme(TextTheme tt) {
  final props = {
    "display-large": textStyle(tt.displayLarge),
    "display-medium": textStyle(tt.displayMedium),
    "display-small": textStyle(tt.displaySmall),
    "headline-large": textStyle(tt.headlineLarge),
    "headline-medium": textStyle(tt.headlineMedium),
    "headline-small": textStyle(tt.headlineSmall),
    "title-large": textStyle(tt.titleLarge),
    "title-medium": textStyle(tt.titleMedium),
    "title-small": textStyle(tt.titleSmall),
    "body-large": textStyle(tt.bodyLarge),
    "body-medium": textStyle(tt.bodyMedium),
    "body-small": textStyle(tt.bodySmall),
    "label-large": textStyle(tt.labelLarge),
    "label-medium": textStyle(tt.labelMedium),
    "label-small": textStyle(tt.labelSmall),
  };
  return IrNativeValue(Value(tt, getters: makeGetters(props)));
}

IrNativeValue textStyle(TextStyle? ts) {
  if (ts == null) return IrNativeValue(Value(null));

  final props = {
    "color": ts.color,
    "background-color": ts.background,
    "decoration": ts.decoration,
    "decoration-color": ts.decorationColor,
    "decoration-style": ts.decorationStyle,
    "decoration-thickness": ts.decorationThickness,
    "font-family": ts.fontFamily,
    "font-size": ts.fontSize,
    "font-weight": ts.fontWeight,
    "font-style": ts.fontStyle,
    "letter-spacing": ts.letterSpacing,
    "word-spacing": ts.wordSpacing,
    "line-height": ts.height,
    "shadows": ts.shadows,
    "font-features": ts.fontFeatures,
  };

  return IrNativeValue(Value(ts, getters: makeGetters(props)));
}
