import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/vision_scaffold.dart';

final scaffold = IrNativeFunc(scaffoldImpl);

Eval<Ir> scaffoldImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createScreen(
    WidgetProperties(properties.unlock),
  ),
  _ => _createScreen(WidgetProperties.empty()),
};

Eval<Ir> _createScreen(WidgetProperties properties) {
  final widget = VisionScaffold(
    key: properties.key,
    appBar: properties.getValue('app-bar'),
    body: properties.getWidget('body'),
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
