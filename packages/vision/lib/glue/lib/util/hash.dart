import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/util/hash.dart';

final Ir hashString = IrNativeFunc((Ir input) {
  if (input case IrString(:final value)) {
    return Eval.pure(IrInteger(hash(value)));
  }

  return throwError(wrongArgumentType(['string value required']));
});
