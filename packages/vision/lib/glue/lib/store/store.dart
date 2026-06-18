import 'package:glue/ir.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/tmp_store.dart';

IrObject store(
  GlueSubscriber subscriber,
  TmpStore tmpStore,
  DataStore dataStore,
  Logger log,
) => IrObject({
  'tmp': IrNativeValue(Value(tmpStore)),
  'persistent': IrNativeValue(Value(dataStore)),
});
