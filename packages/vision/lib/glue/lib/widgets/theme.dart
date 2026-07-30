import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
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
    "primary": makeColor(cs.primary),
    "on-primary": makeColor(cs.onPrimary),
    "primary-container": makeColor(cs.primaryContainer),
    "on-primary-container": makeColor(cs.onPrimaryContainer),

    // Secondary colors
    "secondary": makeColor(cs.secondary),
    "on-secondary": makeColor(cs.onSecondary),
    "secondary-container": makeColor(cs.secondaryContainer),
    "on-secondary-container": makeColor(cs.onSecondaryContainer),

    // Tertiary colors
    "tertiary": makeColor(cs.tertiary),
    "on-tertiary": makeColor(cs.onTertiary),
    "tertiary-container": makeColor(cs.tertiaryContainer),
    "on-tertiary-container": makeColor(cs.onTertiaryContainer),

    // Surface and background variants
    "surface": makeColor(cs.surface),
    "on-surface": makeColor(cs.onSurface),
    "surface-dim": makeColor(cs.surfaceDim),
    "surface-bright": makeColor(cs.surfaceBright),
    "surface-container-lowest": makeColor(cs.surfaceContainerLowest),
    "surface-container-low": makeColor(cs.surfaceContainerLow),
    "surface-container": makeColor(cs.surfaceContainer),
    "surface-container-high": makeColor(cs.surfaceContainerHigh),
    "surface-container-highest": makeColor(cs.surfaceContainerHighest),
    "on-surface-variant": makeColor(cs.onSurfaceVariant),

    // Error colors
    "error": makeColor(cs.error),
    "on-error": makeColor(cs.onError),
    "error-container": makeColor(cs.errorContainer),
    "on-error-container": makeColor(cs.onErrorContainer),

    // Outlines, shadows, and overlays
    "outline": makeColor(cs.outline),
    "outline-variant": makeColor(cs.outlineVariant),
    "shadow": makeColor(cs.shadow),
    "scrim": makeColor(cs.scrim),
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
    "color": makeColor(ts.color),
    "background": ts.background,
    "decoration": ts.decoration,
    "decoration-color": makeColor(ts.decorationColor),
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
