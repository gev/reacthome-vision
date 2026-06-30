import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

final Ir lineTo = handleXY(
  (double x, double y) => (Path path) {
    path.lineTo(x, y);
  },
);
