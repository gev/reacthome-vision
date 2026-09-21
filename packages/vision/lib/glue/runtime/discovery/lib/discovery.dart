import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';

Ir discovery(DiscoveryStore store) => IrNativeFunc((Ir arg) {
  return Eval.pure(IrVoid());
});
