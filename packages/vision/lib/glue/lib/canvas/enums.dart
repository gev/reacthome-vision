import 'dart:ui';

import 'package:glue/ir.dart';

final blendMode = createRegistry(BlendMode.values);
final strokeCap = createRegistry(StrokeCap.values);
final strokeJoin = createRegistry(StrokeJoin.values);
final paintingStyle = createRegistry(PaintingStyle.values);
final filterQuality = createRegistry(FilterQuality.values);
final pathFillType = createRegistry(PathFillType.values);
final clipOp = createRegistry(ClipOp.values);
final tileMode = createRegistry(TileMode.values);
final pointMode = createRegistry(PointMode.values);

String toKebabCase(String name) {
  return name
      .replaceAllMapped(
        RegExp(r'(?<=[a-z0-9])[A-Z]'),
        (match) => '-${match.group(0)!}',
      )
      .toLowerCase();
}

IrObject createRegistry<T extends Enum>(List<T> values) {
  return IrObject(
    Map.fromEntries(
      values.map((v) => MapEntry(toKebabCase(v.name), IrNativeValue(Value(v)))),
    ),
  );
}
