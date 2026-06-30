import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

final Ir moveTo = handleXY(
  (double x, double y) => (Path path) {
    path.moveTo(x, y);
  },
);
