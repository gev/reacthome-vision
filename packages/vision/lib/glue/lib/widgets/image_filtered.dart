import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';

final Ir imageFiltered = IrNativeFunc(imageFilteredImpl);

Eval<Ir> imageFilteredImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createImageFilter(
    WidgetProperties(properties.unlock),
  ),
  _ => throwError(wrongArgumentType(['object'])),
};

Eval<Ir> _createImageFilter(WidgetProperties properties) {
  final imageFilter = properties.getValue<ImageFilter>('image-filter');
  if (imageFilter == null) {
    return throwError(wrongArgumentType(['Required `image-filter` property']));
  }
  final imageFilteredWidget = ImageFiltered(
    key: properties.key,
    imageFilter: imageFilter,
    child: properties.child,
  );
  return Eval.pure(IrNativeValue(Value(imageFilteredWidget)));
}
