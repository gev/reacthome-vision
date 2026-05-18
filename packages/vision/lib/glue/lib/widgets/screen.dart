import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/screen.dart';

final screen = IrNativeFunc(screenImpl);

Eval<Ir> screenImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createScreen(
    WidgetProperties(properties.unlock),
  ),
  _ => _createScreen(WidgetProperties.empty()),
};

Eval<Ir> _createScreen(WidgetProperties properties) {
  final widget = Screen(
    key: properties.key,
    appBar: properties.getValue('app-bar'),
    body: properties.getWidget('body'),
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
