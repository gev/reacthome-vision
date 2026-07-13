import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/curtain/double_horizontal_curtain.dart';
import 'package:vision/widgets/curtain/left_curtain.dart';
import 'package:vision/widgets/curtain/right_curtain.dart';
import 'package:vision/widgets/curtain/vertical_curtain.dart';

/// DoubleHorizontalCurtain widget function
final Ir doubleHorizontalCurtain = IrNativeFunc(
  curtainImpl(
    curtain: DoubleHorizontalCurtain.new,
    defaultHeight: 160,
    defaultWidth: 320,
  ),
);

/// LeftCurtain widget function
final Ir leftCurtain = IrNativeFunc(
  curtainImpl(curtain: LeftCurtain.new, defaultHeight: 160, defaultWidth: 250),
);

/// RightCurtain widget function
final Ir rightCurtain = IrNativeFunc(
  curtainImpl(curtain: RightCurtain.new, defaultHeight: 160, defaultWidth: 250),
);

/// VerticalCurtain widget function
final Ir verticalCurtain = IrNativeFunc(
  curtainImpl(
    curtain: VerticalCurtain.new,
    defaultHeight: 250,
    defaultWidth: 160,
  ),
);

/// Curtain implementation
Eval<Ir> Function(Ir props) curtainImpl({
  required dynamic curtain,
  required double defaultHeight,
  required double defaultWidth,
}) =>
    (Ir props) => switch (props) {
      IrObject(:final properties) => _createCurtain(
        curtain: curtain,
        defaultHeight: defaultHeight,
        defaultWidth: defaultWidth,
        properties: WidgetProperties(properties.unlock),
      ),
      _ => throwError(wrongArgumentType(['object'])),
    };

/// Create curtain widget from properties
Eval<Ir> _createCurtain({
  required dynamic curtain,
  required double defaultHeight,
  required double defaultWidth,
  required WidgetProperties properties,
}) {
  return getRuntime().bind((runtime) {
    final curtainWidget = curtain(
      value: properties.getDouble('value') ?? 0,
      onChanged: (value) {
        properties.getCallback<double>('on-changed')?.call(runtime).call(value);
      },
      activeColor: properties.getColor('active-color'),
      inactiveColor: properties.getColor('inactive-color'),
      height: properties.getDouble('height') ?? defaultHeight,
      width: properties.getDouble('width') ?? defaultWidth,
      frameRadius: properties.getDouble('frame-radius') ?? 4.0,
      edgeRadius: properties.getDouble('edge-radius') ?? 16.0,
      focusedRadius: properties.getDouble('focused-radius') ?? 32.0,
      translucent: properties.getBool('translucent') ?? false,
      jumpToTap: properties.getBool('jump-to-tap') ?? true,
      enableHapticOnTap: properties.getBool('enable-haptic-on-tap') ?? true,
      enableHapticOnBounds:
          properties.getBool('enable-haptic-on-bounds') ?? true,
    );

    return Eval.pure(IrNativeValue(Value(curtainWidget)));
  });
}
