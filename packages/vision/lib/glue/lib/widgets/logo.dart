import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/logo.dart';

/// Logo widget function
/// Creates Flutter Logo from Glue (sized-box props) expressions
final Ir logo = IrNativeFunc(logoImpl);

/// Logo implementation - takes properties object
Eval<Ir> logoImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createLogo(
    WidgetProperties(properties.unlock),
  ),
  _ => throwError(wrongArgumentType(['object'])),
};

/// Create Logo widget from properties
Eval<Ir> _createLogo(WidgetProperties properties) {
  final logoWidget = Logo(
    key: properties.key,
    width: properties.width,
    height: properties.height,
  );
  return Eval.pure(IrNativeValue(Value(logoWidget)));
}
