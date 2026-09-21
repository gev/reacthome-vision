import 'package:glue/env.dart';
import 'package:glue/module.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/discovery/lib/discovery_module.dart';

Env makeDiscoveryEnv(DiscoveryStore store) =>
    envFromModules([discoveryModule(store)]);
