import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/canvas/handler.dart';
import 'package:vision/glue/widgets/glue_canvas.dart';

/// Creates a Canvas widget
final Ir canvas = IrNativeFunc((Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      return getEnv().bind((env) {
        final props = WidgetProperties(properties.unlock);
        return Eval.pure(
          IrNativeValue(
            Value(
              GlueCanvas(
                env: env,
                key: props.key,
                width: props.width,
                height: props.height,
                foreground: props.getValues<CanvasHandler>('foreground'),
                background: props.getValues<CanvasHandler>('background'),
              ),
            ),
          ),
        );
      });
    default:
      return throwError(wrongArgumentType(['Required `Canvas` object']));
  }
});
