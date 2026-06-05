import 'package:glue/ir.dart';
import 'package:vision/stores/put.dart';

class ModuleStore implements Put<IrDottedSymbol, Ir> {
  @override
  void put(IrDottedSymbol key, Ir value) {
    print(key);
    print(value);
  }
}
