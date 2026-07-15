import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/closures/double_curtain.dart';
import 'package:vision/widgets/closures/double_gate.dart';
import 'package:vision/widgets/closures/left_curtain.dart';
import 'package:vision/widgets/closures/left_gate.dart';
import 'package:vision/widgets/closures/right_curtain.dart';
import 'package:vision/widgets/closures/right_gate.dart';
import 'package:vision/widgets/closures/shutter.dart';

/// DoubleCurtain widget function
final Ir doubleCurtain = IrNativeFunc(
  curtainImpl(
    curtain: DoubleCurtain.new,
    defaultHeight: 160,
    defaultWidth: 320,
  ),
);

/// DoubleGate widget function
final Ir doubleGate = IrNativeFunc(
  curtainImpl(curtain: DoubleGate.new, defaultHeight: 160, defaultWidth: 320),
);

/// LeftCurtain widget function
final Ir leftCurtain = IrNativeFunc(
  curtainImpl(curtain: LeftCurtain.new, defaultHeight: 160, defaultWidth: 250),
);

/// LeftGate widget function
final Ir leftGate = IrNativeFunc(
  curtainImpl(curtain: LeftGate.new, defaultHeight: 160, defaultWidth: 250),
);

/// RightCurtain widget function
final Ir rightCurtain = IrNativeFunc(
  curtainImpl(curtain: RightCurtain.new, defaultHeight: 160, defaultWidth: 250),
);

/// RightGate widget function
final Ir rightGate = IrNativeFunc(
  curtainImpl(curtain: RightGate.new, defaultHeight: 160, defaultWidth: 250),
);

/// VerticalCurtain widget function
final Ir shutter = IrNativeFunc(
  curtainImpl(curtain: Shutter.new, defaultHeight: 250, defaultWidth: 160),
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
