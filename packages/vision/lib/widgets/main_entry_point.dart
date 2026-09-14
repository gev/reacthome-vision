import 'package:glue/ir.dart';

// (
//   (import main)
//   main
// )

final mainEntryPoint = IrList([
  IrList([IrSymbol('import'), IrSymbol('main')]),
  IrSymbol('main'),
]);
