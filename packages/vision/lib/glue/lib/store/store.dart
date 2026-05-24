import 'package:glue/ir.dart';
import 'package:vision/glue/store/tmp.dart';
import 'package:vision/pub_sub/subscriber.dart';

IrObject store(Subscriber<String> subscriber) =>
    IrObject({'tmp': IrNativeValue(Value(tmp(subscriber)))});
