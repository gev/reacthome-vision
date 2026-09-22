import 'package:glue/env.dart';
import 'package:glue/lib/bool.dart';
import 'package:glue/lib/builtin.dart';
import 'package:glue/lib/io.dart';
import 'package:glue/lib/list.dart';
import 'package:glue/lib/math/arithmetic.dart';
import 'package:glue/lib/math/const.dart';
import 'package:glue/lib/math/utility.dart';
import 'package:glue/module.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/lib/applets_module.dart';
import 'package:vision/glue/lib/canvas_module.dart';
import 'package:vision/glue/lib/module_module.dart';
import 'package:vision/glue/lib/navigation_module.dart';
import 'package:vision/glue/lib/rate_limit_module.dart';
import 'package:vision/glue/lib/routes_module.dart';
import 'package:vision/glue/lib/state_module.dart';
import 'package:vision/glue/lib/widgets.dart';
import 'package:vision/glue/runtime/local/lib/local_discovery_module.dart';
import 'package:vision/glue/runtime/local/lib/module/local_import.dart';
import 'package:vision/glue/runtime/local/lib/widgets/local_image.dart';
import 'package:vision/glue/runtime/local/local_reactive_runtime.dart';
import 'package:vision/glue/runtime/local/local_storage.dart';
import 'package:vision/logger.dart';

Env makeLocalEnv({
  required LocalReactiveRuntime runtime,
  required LocalStorage storage,
  required DiscoveryStore discoveryStore,
  required Logger log,
}) {
  return envFromModules([
    builtinModule,
    boolModule,
    arithmeticModule,
    utilityModule,
    constModule,
    listModule,
    uiCoreModule,
    uiMaterialModule,
    navigationModule,
    routesModule,
    canvasModule,
    ioModule,
    appletsModule,
    localDiscoveryModule(discoveryStore),
    rateLimitModule(log),
    localStateModule(storage),
    widgetsModule(image: localImage),
    moduleModule(import: localImport(runtime)),
  ]);
}
