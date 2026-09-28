import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/widgets/getters.dart';

/// Provides access to the current MediaQueryData through the Glue IR system.
/// Usage in Glue: media-query.width, media-query.padding.top, media-query.view-insets.bottom, etc.
final Ir mediaQuery = IrEvaluable(() {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    return Eval.pure(
      context != null ? mediaQueryData(MediaQuery.of(context)) : IrObject({}),
    );
  });
});

/// Converts Flutter's EdgeInsets into a Map/IrObject with standard direction keys.
Ir _edgeInsetsToMap(EdgeInsets insets) => IrObject({
  "top": toIr(insets.top),
  "bottom": toIr(insets.bottom),
  "left": toIr(insets.left),
  "right": toIr(insets.right),
});

/// Maps Flutter's MediaQueryData into an IrNativeValue with kebab-case getters.
IrNativeValue mediaQueryData(MediaQueryData mq) {
  final props = {
    // Screen dimensions
    "size": IrObject({
      "width": toIr(mq.size.width),
      "height": toIr(mq.size.height),
    }),

    // Physical/Logical pixel ratio
    "device-pixel-ratio": mq.devicePixelRatio,

    // Dynamic Safe Area (resets to 0 under keyboard)
    "padding": _edgeInsetsToMap(mq.padding),

    // Software keyboard and overlapping system UI
    "view-insets": _edgeInsetsToMap(mq.viewInsets),

    // Static Safe Area (physical notches/bars, unchanged by keyboard)
    "view-padding": _edgeInsetsToMap(mq.viewPadding),

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
