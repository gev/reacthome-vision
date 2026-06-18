import 'package:glue/env.dart';
import 'package:glue/lib/bool.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/lib/list.dart';
import 'package:glue/lib/math/arithmetic.dart';
import 'package:glue/module.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/module.dart';
import 'package:vision/glue/lib/navigation.dart';
import 'package:vision/glue/lib/rpc.dart';
import 'package:vision/glue/lib/state.dart';
import 'package:vision/glue/lib/store.dart';
import 'package:vision/glue/lib/widgets.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';
import 'package:vision/glue/stores/tmp_store.dart';
import 'package:vision/persistent/assets.dart';

Env makeEnv({
  required Sink<String> sink,
  required GlueSubscriber subscriber,
  required ReactiveRuntime runtime,
  required TmpStore tmpStore,
  required DataStore dataStore,
  required Assets assets,
  required Logger log,
}) {
  return envFromModules([
    builtinModule,
    boolModule,
    arithmeticModule,
    listModule,
    uiCoreModule,
    uiMaterialModule,
    widgetsModule(assets),
    navigationModule,
    stateModule(log),
    moduleModule(subscriber, runtime),
    storeModule(subscriber, tmpStore, dataStore, log),
    rpcModule(sink),
  ]);
}
