import 'package:glue/compile.dart';
import 'package:glue/env.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';
import 'package:vision/glue/logger.dart';

class GlueEvaluator {
  late final Env _env;
  late final Logger _log;

  GlueEvaluator({required this._env, required this._log});

  Future<Ir?> evaluate(String code) async {
    final parseResult = parseGlue(code);
    return parseResult.match(
      (parseError) {
        _log.error(parseError);
        return null;
      },
      (ast) async {
        final irTree = compile(ast);
        final evalResult = await runEvalSimple(eval(irTree), _env);
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
