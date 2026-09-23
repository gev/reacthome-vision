import 'dart:io';

import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';

Ir discovery(DiscoveryStore store) => IrNativeFunc(
  (Ir arg) => getRuntime().map((runtime) {
    final address = getFromContext<InternetAddress>(runtime.context);
    print(address);
    if (address != null) {
      print(address.host);
    }
    return IrVoid();
  }),
);
