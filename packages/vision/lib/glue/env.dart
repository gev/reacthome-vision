import 'package:glue/lib/bool.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/lib/list.dart';
import 'package:glue/lib/math/arithmetic.dart';
import 'package:glue/module.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/state.dart';
import 'package:vision/glue/lib/store.dart';

final env = envFromModules([
  builtinModule,
  boolModule,
  arithmeticModule,
  listModule,
  uiCoreModule,
  uiMaterialModule,
  stateModule,
  storeModule,
]);
