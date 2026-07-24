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
import 'package:vision/glue/lib/rpc.dart';
import 'package:vision/glue/lib/store.dart';
import 'package:vision/glue/lib/widgets.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/live/glue/lib/connectivity.dart';
import 'package:vision/mode/live/glue/lib/module/live_import.dart';
import 'package:vision/mode/live/glue/lib/state.dart';
import 'package:vision/mode/live/glue/lib/widgets/live_image.dart';
import 'package:vision/mode/live/glue/live_reactive_runtime.dart';
import 'package:vision/mode/live/live_storage.dart';
import 'package:vision/websocket/session_monitor.dart';

Env makeLiveEnv({
  required Sink<String> sink,
  required GlueSubscriber subscriber,
  required LiveReactiveRuntime runtime,
  required LiveStorage storage,
  required SessionMonitor monitor,
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
    liveStateModule(storage, log),
    widgetsModule(image: liveImage(storage.assets)),
    moduleModule(import: liveImport(subscriber, runtime)),
    storeModule(subscriber),
    rpcModule(sink),
    connectivityModule(monitor),
  ]);
}
