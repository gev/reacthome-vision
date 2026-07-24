import 'package:glue/env.dart';
import 'package:glue/lib/bool.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/lib/list.dart';
import 'package:glue/lib/math/arithmetic.dart';
import 'package:glue/lib/math/utility.dart';
import 'package:glue/module.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/canvas.dart';
import 'package:vision/glue/lib/module.dart';
import 'package:vision/glue/lib/navigation.dart';
import 'package:vision/glue/lib/routes.dart';
import 'package:vision/glue/lib/state.dart';
import 'package:vision/glue/lib/widgets.dart';
import 'package:vision/glue/stores/glue_reactive_db.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/local/glue/lib/module/local_import.dart';
import 'package:vision/mode/local/glue/lib/widgets/local_image.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';
import 'package:vision/mode/local/local_storage.dart';

Env makeLocalEnv({
  required LocalReactiveRuntime runtime,
  required LocalStorage storage,
  required Logger log,
}) {
  return envFromModules([
    builtinModule,
    boolModule,
    arithmeticModule,
    utilityModule,
    listModule,
    uiCoreModule,
    uiMaterialModule,
    navigationModule,
    routesModule,
    canvasModule,
    localStateModule(storage, log),
    widgetsModule(image: localImage),
    moduleModule(import: localImport(runtime)),
  ]);
}
