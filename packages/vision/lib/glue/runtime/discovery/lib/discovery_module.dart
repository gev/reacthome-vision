import 'package:glue/module.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/discovery/lib/discovery.dart';

ModuleInfo discoveryModule(DiscoveryStore store) =>
    nativeModule('ffi.vision.discovery', [('discovery', discovery(store))]);
