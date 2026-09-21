import 'package:glue/ir.dart';
import 'package:glue/module.dart';

ModuleInfo moduleModule({required Ir import}) {
  return nativeModule('ffi.vision.module', [('import', import)]);
}
