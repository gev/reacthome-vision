import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/canvas/handler.dart';
import 'package:vision/glue/widgets/glue_canvas.dart';

/// Creates a Canvas widget
final Ir canvas = IrNativeFunc((Ir props) {
  final properties = WidgetProperties(props);
  return Eval.pure(
    IrNativeValue(
      Value(
        GlueCanvas(
          key: properties.key,
          width: properties.width ?? 0,
          height: properties.height ?? 0,
          foreground: properties.getValues<CanvasHandler>('foreground'),
          background: properties.getValues<CanvasHandler>('background'),
          child: properties.child,
        ),
      ),
    ),
  );
});
