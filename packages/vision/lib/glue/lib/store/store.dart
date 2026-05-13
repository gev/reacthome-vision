import 'package:glue/ir.dart';
import 'package:vision/glue/store/tmp.dart';

Ir store(Sink<String> sink) {
  return IrObject({'tmp': IrNativeValue(Value(tmp(sink)))});
}
