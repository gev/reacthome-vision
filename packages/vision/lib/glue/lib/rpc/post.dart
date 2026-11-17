import 'dart:convert';
import 'dart:typed_data';

import 'package:glue/decompile.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/serialize.dart';

Ir post(Sink<Uint8List> sink) {
  Eval<Ir> postImpl(Ir ir) {
    return decompile(ir).match(
      (error) {
        return throwError(wrongArgumentType([error]));
      },
      (ast) {
        sink.add(utf8.encode(serializeAst(ast)));
        return Eval.pure(IrVoid());
      },
    );
  }

  return IrNativeFunc(postImpl);
}
