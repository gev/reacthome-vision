import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

final Ir relativeMoveTo = handleXY(
  (double x, double y) => (Path path) {
    path.relativeMoveTo(x, y);
  },
);
