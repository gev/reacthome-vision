import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/widgets/empty_widget.dart';

final placeholder = IrEvaluable(
  () => Eval.pure(IrNativeValue(Value(EmptyWidget()))),
);
