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
      final props = WidgetProperties(properties.unlock);
      return Eval.pure(
        IrNativeValue(
          Value(
            GlueCanvas(
              key: props.key,
              width: props.width ?? 0,
              height: props.height ?? 0,
              foreground: props.getValues<CanvasHandler>('foreground'),
              background: props.getValues<CanvasHandler>('background'),
              child: props.child,
            ),
          ),
        ),
      );
    default:
      return throwError(wrongArgumentType(['Required `Canvas` object']));
  }
});
