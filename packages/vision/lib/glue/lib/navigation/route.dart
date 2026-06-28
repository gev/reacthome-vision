import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

typedef RouteEntry = ({String route, IrObject args});

Eval<RouteEntry> evalRoute(Ir ir) {
  if (ir case IrObject(:final properties)) {
    Ir? route;
    final args = <String, Ir>{};
    for (final entry in properties.entries) {
      if (entry.key == 'route') {
        route = entry.value;
      } else {
        args[entry.key] = entry.value;
      }
    }
    if (route case IrSymbol(:final value)) {
      return Eval.pure((route: value, args: IrObject(args)));
    }
  }
  return throwError(wrongArgumentType(['Object with `route` required ']));
}

Eval<Ir> routeResult<T>(Future<T?> res) => Eval.pure(IrNativeValue(Value(res)));
