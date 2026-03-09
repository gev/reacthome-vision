import 'package:glue/env.dart';
import 'package:glue/lib/bool.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/lib/list.dart';
import 'package:glue/lib/math/arithmetic.dart';
import 'package:glue/module.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/navigation.dart';
import 'package:vision/glue/lib/state.dart';
import 'package:vision/glue/lib/store.dart';
import 'package:vision/glue/lib/widgets.dart';
import 'package:vision/store/pool.dart';

Env makeEnv(Sink<String> sink, Pool<String> pool) {
  return envFromModules([
    builtinModule,
    boolModule,
    arithmeticModule,
    listModule,
    uiCoreModule,
    uiMaterialModule,
    widgetsModule,
    navigationModule,
    stateModule,
    storeModule(sink, pool),
  ]);
}
