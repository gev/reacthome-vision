import 'package:glue/decompile.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/serialize.dart';

Ir post(Sink<String> sink) {
  Eval<Ir> postImpl(Ir ir) {
    return decompile(ir).match(
      (error) {
        return throwError(wrongArgumentType([error]));
      },
      (ast) {
        sink.add(serializeAst(ast));
        return Eval.pure(IrVoid());
      },
    );
  }

  return IrNativeFunc(postImpl);
}
