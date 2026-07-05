import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/widgets/getters.dart';

/// Provides access to the current MediaQueryData through the Glue IR system.
/// Usage in Glue: media-query.width, media-query.padding-top, etc.
final Ir mediaQuery = IrEvaluable(() {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    return Eval.pure(
      context != null ? mediaQueryData(MediaQuery.of(context)) : IrObject({}),
    );
  });
});

/// Maps Flutter's MediaQueryData into an IrNativeValue with kebab-case getters.
IrNativeValue mediaQueryData(MediaQueryData mq) {
  final props = {
    // Screen dimensions
    "width": mq.size.width,
    "height": mq.size.height,

    // Physical/Logical pixel ratio
    "device-pixel-ratio": mq.devicePixelRatio,

    // Padding (notches, status bars, system navigation bars)
    "padding-top": mq.padding.top,
    "padding-bottom": mq.padding.bottom,
    "padding-left": mq.padding.left,
    "padding-right": mq.padding.right,

    // Insets (usually occupied by the on-screen keyboard)
    "view-insets-bottom": mq.viewInsets.bottom,
    "view-insets-top": mq.viewInsets.top,

    // View padding (similar to padding, but excludes system UI elements)
    "view-padding-bottom": mq.viewPadding.bottom,

    // System settings
    "text-scaler": mq.textScaler,
    "platform-brightness": mq.platformBrightness,
    "always-use-24-hour-format": mq.alwaysUse24HourFormat,

    // Orientation and accessibility
    "orientation": mq.orientation,
    "accessible-navigation": mq.accessibleNavigation,
    "bold-text": mq.boldText,
    "disable-animations": mq.disableAnimations,
    "high-contrast": mq.highContrast,
  };

  return IrNativeValue(Value(mq, getters: makeGetters(props)));
}
