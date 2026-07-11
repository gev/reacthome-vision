import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/slider/circular_slider.dart';

/// CircularSlider widget function
final Ir circularSlider = IrNativeFunc(circularSliderImpl);

/// CircularSlider implementation
Eval<Ir> circularSliderImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createCircularSlider(
    WidgetProperties(properties.unlock),
  ),
  _ => throwError(wrongArgumentType(['object'])),
};

/// Create CircularSlider widget from properties
Eval<Ir> _createCircularSlider(WidgetProperties properties) {
  return getRuntime().bind((runtime) {
    final sliderWidget = CircularSlider(
      value: properties.getDouble('value') ?? 0,
      min: properties.getDouble('min') ?? 0,
      max: properties.getDouble('max') ?? 1,
      onChanged: (value) {
        properties.getCallback<double>('on-changed')?.call(runtime).call(value);
      },
      activeColor: properties.getColor('active-color'),
      inactiveColor: properties.getColor('inactive-color'),
      startAngle: properties.getDouble('start-angle') ?? -pi * 1.25,
      endAngle: properties.getDouble('end-angle') ?? pi * 0.25,
      diameter: properties.getDouble('diameter') ?? 150,
      width: properties.getDouble('width') ?? 24.0,
      focusedWidth: properties.getDouble('focused-width') ?? 36.0,
      cap: properties.getValue<StrokeCap>('border-radius') ?? StrokeCap.round,
      enableHapticOnTap: properties.getBool('enable-haptic-on-tap') ?? true,
      enableHapticOnBounds:
          properties.getBool('enable-haptic-on-bounds') ?? true,
    );

    return Eval.pure(IrNativeValue(Value(sliderWidget)));
  });
}
