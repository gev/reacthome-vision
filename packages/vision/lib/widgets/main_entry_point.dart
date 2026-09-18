import 'package:glue/ir.dart';

// (
//   (import main)
//   (main args)
// )

Ir mainEntryPoint(Ir args) => IrList([
  IrList([IrSymbol('import'), IrSymbol('main')]),
  IrList([IrSymbol('main'), args]),
]);

const defaultRoute = 'index';
