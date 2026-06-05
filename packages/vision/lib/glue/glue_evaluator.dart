import 'package:glue/compile.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/logger.dart';

class GlueEvaluator {
  late final Runtime _runtime;
  late final Logger _log;

  GlueEvaluator({required this._runtime, required this._log});

  Future<Ir?> evaluate(String code) async {
    final parseResult = parseGlue(code);
    return parseResult.match(
      (parseError) {
        _log.error(parseError);
        return null;
      },
      (ast) async {
        final irTree = compile(ast);
        final evalResult = await runEval(eval(irTree), _runtime);
        return evalResult.match(
          (error) {
            _log.error(error);
            return null;
          },
          (value) {
            return value.$1;
          },
        );
      },
    );
  }
}
