import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/slider/horizontal_slider.dart';

/// HorizontalSlider widget function
final Ir horizontalSlider = IrNativeFunc(horizontalSliderImpl);

/// HorizontalSlider implementation
Eval<Ir> horizontalSliderImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createHorizontalSlider(
    WidgetProperties(properties.unlock),
  ),
  _ => throwError(wrongArgumentType(['object'])),
};

/// Create HorizontalSlider widget from properties
Eval<Ir> _createHorizontalSlider(WidgetProperties properties) {
  return getRuntime().bind((runtime) {
    final sliderWidget = HorizontalSlider(
      value: properties.getDouble('value') ?? 0,
      min: properties.getDouble('min') ?? 0,
      max: properties.getDouble('max') ?? 1,
      onChanged: properties.getCallback<double>('on-changed')?.call(runtime),
      activeColor: properties.getColor('active-color'),
      inactiveColor: properties.getColor('inactive-color'),
      width: properties.getDouble('width') ?? 250.0,
      height: properties.getDouble('height') ?? 40,
      focusedHeight: properties.getDouble('focused-height') ?? 60.0,
      borderRadius: properties.getDouble('border-radius') ?? 20.0,
      jumpToTap: properties.getBool('jump-to-tap') ?? true,
      enableHapticOnTap: properties.getBool('enable-haptic-on-tap') ?? true,
      enableHapticOnBounds:
          properties.getBool('enable-haptic-on-bounds') ?? true,
    );

    return Eval.pure(IrNativeValue(Value(sliderWidget)));
  });
}
