import 'package:glue/ir.dart';

const defaultRoute = 'index';

// (
//   (import main)
//   (main args)
// )
Ir mainEntryPoint(Ir args) => IrList([
  IrList([IrSymbol('import'), IrSymbol('main')]),
  IrList([IrSymbol('main'), args]),
]);

// (
//   (import api)
//   endpoint
// )
Ir apiEndpoint(Ir endpoint) => IrList([
  IrList([IrSymbol('import'), IrSymbol('api')]),
  endpoint,
]);
