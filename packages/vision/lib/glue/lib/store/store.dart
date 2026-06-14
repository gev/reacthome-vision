import 'dart:io';

import 'package:glue/ir.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/tmp_store.dart';

IrObject store(Directory path, GlueSubscriber subscriber, Logger log) =>
    IrObject({
      'tmp': IrNativeValue(Value(tmpStore(subscriber))),
      'persistent': IrNativeValue(Value(dataStore(path, subscriber, log))),
    });
