import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Checks if the navigation stack can pop
final canPop = IrEvaluable(() {
  final res = AppNavigator.canPop();
  return Eval.pure(IrBool(res));
});
