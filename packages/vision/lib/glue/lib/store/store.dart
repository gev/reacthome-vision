import 'package:glue/ir.dart';
import 'package:vision/glue/store/tmp.dart';

IrObject store(Sink<String> sink) =>
    IrObject({'tmp': IrNativeValue(Value(tmp(sink)))});
