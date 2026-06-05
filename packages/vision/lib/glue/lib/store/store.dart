import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/store/tmp_store.dart';

IrObject store(GlueSubscriber subscriber) =>
    IrObject({'tmp': IrNativeValue(Value(tmpStore(subscriber)))});
