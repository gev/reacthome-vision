import 'package:glue/compile.dart';
import 'package:glue/either.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';

class GlueEvaluator {
  late final Env _env;

  GlueEvaluator(this._env);

  Future<Either<GlueError, Ir>> evaluate(String code) async {
    final parseResult = parseGlue(code);
    return parseResult.match(
      (parseError) {
        return Left(parseError);
      },
      (ast) async {
        final irTree = compile(ast);
        final evalResult = await runEvalSimple(eval(irTree), _env);
        return evalResult.match(
          (error) => Left(error),
          (value) => Right(value.$1),
        );
      },
    );
  }
}
