import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/group.dart';
import 'package:vision/glue/widgets/glue_canvas.dart';

/// Creates a Canvas widget
final Ir canvas = IrSpecial(
  (List<Ir> rawArgs) => getEnv().bind((env) {
    return sequenceAll(rawArgs.map(eval).toList()).bind((commands) {
      final expression = IrNativeValue(Value(makeGroup(commands)));
      final canvas = GlueCanvas(expression: expression, env: env);
      return Eval.pure(IrNativeValue(Value(canvas)));
    });
  }),
);
