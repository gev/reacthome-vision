import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';

Ir discoveredServices(DiscoveryStore store) => IrNativeValue(Value(store));
