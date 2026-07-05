import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/slider/vertical_slider.dart';

/// VerticalSlider widget function
final Ir verticalSlider = IrNativeFunc(verticalSliderImpl);

/// VerticalSlider implementation
Eval<Ir> verticalSliderImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createVerticalSlider(
    WidgetProperties(properties.unlock),
  ),
  _ => throwError(wrongArgumentType(['object'])),
};

/// Create VerticalSlider widget from properties
Eval<Ir> _createVerticalSlider(WidgetProperties properties) {
  return getRuntime().bind((runtime) {
    final sliderWidget = VerticalSlider(
      value: properties.getDouble('value') ?? 0,
      secondaryTrackValue: properties.getDouble('secondary-track-value'),
      min: properties.getDouble('min') ?? 0,
      max: properties.getDouble('max') ?? 1,
      onChanged: (value) {
        properties.getCallback<double>('on-changed')?.call(runtime).call(value);
      },
      activeColor: properties.getColor('active-color'),
      inactiveColor: properties.getColor('inactive-color'),
      secondaryActiveColor: properties.getColor('secondary-active-color'),
      top: properties.getWidget('top'),
      bottom: properties.getWidget('bottom'),
      center: properties.getWidget('center'),
      width: properties.getDouble('width') ?? 40.0,
      focusedWidth: properties.getDouble('focused-width') ?? 60.0,
      borderRadius: properties.getDouble('border-radius') ?? 20.0,
      displayValue: properties.getBool('display-value') ?? true,
      jumpToTap: properties.getBool('jump-to-tap') ?? true,
      enableHapticOnTap: properties.getBool('enable-haptic-on-tap') ?? true,
      enableHapticOnBounds:
          properties.getBool('enable-haptic-on-bounds') ?? true,
    );

    return Eval.pure(IrNativeValue(Value(sliderWidget)));
  });
}
