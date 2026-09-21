import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/logger.dart';
import 'package:vision/rate_limit/debouncer.dart';

Ir debounce(Logger log) => IrNativeFunc((Ir delayIr) {
  final delay = to<Duration>(delayIr);
  if (delay == null) {
    return throwError(wrongArgumentType(['Duration delay parameter required']));
  }
  final debouncer = Debouncer(delay);
  return Eval.pure(
    IrSpecial((List<Ir> expr) {
      return getRuntime().bind((runtime) {
        debouncer.call(() {
          final res = runEval(sequenceAll(expr.map(eval).toList()), runtime);
          if (res case Left e) {
            log.error(e);
          }
        });
        return Eval.pure(IrVoid());
      });
    }),
  );
});
