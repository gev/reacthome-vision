import 'package:glue/compile.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/parse.dart';

class GlueEvaluator {
  late final Env _env;

  GlueEvaluator(this._env);

  Future<GlueError?> evaluate(String code) async {
    final parseResult = parseGlue(code);
    return parseResult.match(
      (parseError) {
        return parseError;
      },
      (ast) async {
        final irTree = compile(ast);
        final evalResult = await runEvalSimple(eval(irTree), _env);
        return evalResult.match((error) => error, (_) => null);
      },
    );
  }
}
