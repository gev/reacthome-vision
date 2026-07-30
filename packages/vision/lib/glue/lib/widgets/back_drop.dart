import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir backdrop = IrNativeFunc((props) {
  return switch (props) {
    IrObject(:final properties) => Eval.pure(
      IrNativeValue(
        Value(
          BackdropFilter(
            filter: to<ImageFilter>(properties['filter']),
            child: to<Widget>(properties['child']),
          ),
        ),
      ),
    ),
    _ => throwError(wrongArgumentType(['`Object` filter and child required'])),
  };
});
