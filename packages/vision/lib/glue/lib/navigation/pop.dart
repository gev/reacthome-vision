import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Pops the current route, optionally passing a result
final Ir pop = IrNativeFunc((Ir resultIr) {
  AppNavigator.pop(resultIr);
  return Eval.pure(IrVoid());
});
