import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_canvas.dart';

/// Creates a Canvas widget
final Ir canvas = IrSpecial(
  (List<Ir> ir) => getEnv().bind((env) {
    switch (ir) {
      case [Ir expreesion]:
        final canvas = GlueCanvas(expression: expreesion, env: env);
        return Eval.pure(IrNativeValue(Value(canvas)));
      default:
        return throwError(wrongArgumentType(['required canvas painter']));
    }
  }),
);
