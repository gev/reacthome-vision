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
import 'package:vision/glue/lib/rpc_module.dart';
import 'package:vision/glue/lib/store_module.dart';
import 'package:vision/glue/lib/widgets.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/runtime/live/lib/connectivity_module.dart';
import 'package:vision/glue/runtime/live/lib/live_state_module.dart';
import 'package:vision/glue/runtime/live/lib/module/live_import.dart';
import 'package:vision/glue/runtime/live/lib/widgets/live_image.dart';
import 'package:vision/glue/runtime/live/live_reactive_runtime.dart';
import 'package:vision/glue/runtime/live/live_storage.dart';
import 'package:vision/logger.dart';
import 'package:vision/websocket/session_monitor.dart';

Env makeLiveEnv({
  required Sink<String> sink,
  required GlueSubscriber subscriber,
  required LiveReactiveRuntime runtime,
  required LiveStorage storage,
  required DiscoveryStore discoveryStore,
  required SessionMonitor monitor,
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
    appletsModule(discoveryStore),
    rateLimitModule(log),
    liveStateModule(storage),
    widgetsModule(image: liveImage(storage.assets)),
    moduleModule(import: liveImport(subscriber, runtime)),
    storeModule(subscriber),
    rpcModule(sink),
    connectivityModule(monitor),
  ]);
}
