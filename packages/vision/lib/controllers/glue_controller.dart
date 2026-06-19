import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:glue/compile.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/parse.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';

class GlueController {
  late final ReactiveRuntime _runtime;
  late final Logger _log;

  GlueController({required this._runtime, required this._log});

  void runGlue(Uint8List body) async {
    try {
      final code = utf8.decode(body);
      final parseResult = parseGlue(code);
      return parseResult.match(
        (parseError) {
          _log.error(parseError);
          return null;
        },
        (ast) async {
          final irTree = compile(ast);
          final evalResult = await runEval(eval(irTree), _runtime.runtime);
          if (evalResult case Left(value: final error)) {
            _log.error(error);
          }
        },
      );
    } catch (error) {
      _log.error(error);
    }
  }
}
