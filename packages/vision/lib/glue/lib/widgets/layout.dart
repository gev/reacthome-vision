import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_layout.dart';

/// Creates a LayoutBuilder from an IrObject
final Ir layout = IrNativeFunc(
  (expression) =>
      Eval.pure(IrNativeValue(Value(GlueLayout(expression: expression)))),
);
