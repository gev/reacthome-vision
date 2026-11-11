import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:glue/compile.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';
import 'package:glue/runtime.dart';
import 'package:vision/logger.dart';

class GlueController {
  late final Logger _log;

  GlueController({required this._log});

  void runGlue(Uint8List body, Runtime runtime) {
    final ir = compileGlue(body);
    if (ir != null) {
      evalGlue(ir, runtime);
    }
  }

  Ir? compileGlue(Uint8List body) {
    try {
      final code = utf8.decode(body);
      switch (parseGlue(code)) {
        case Left(value: final error):
          _log.error(error);
          return null;
        case Right(value: final ast):
          return compile(ast);
      }
    } catch (error) {
      _log.error(error);
      return null;
    }
  }

  void evalGlue(Ir ir, Runtime runtime) {
    final evalResult = runEval(eval(ir), runtime);
    if (evalResult case Left(value: final error)) {
      _log.error(error);
    }
  }
}
