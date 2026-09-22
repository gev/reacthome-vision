import 'package:glue/module.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/lib/discovery/discovery.dart';

ModuleInfo localDiscoveryModule(DiscoveryStore store) => nativeModule(
  'ffi.vision.discovery',
  [('discovered-services', discoveredServices(store))],
);
