import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Pushes a Route onto the navigation stack
final Ir push = IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      switch (ir) {
        case IrObject(:final properties):
          Ir? route;
          final args = <String, Ir>{};
          for (final entry in properties.entries) {
            print(entry);
            if (entry.key == 'route') {
              route = entry.value;
            } else {
              args[entry.key] = entry.value;
            }
          }
          switch (route) {
            case (IrSymbol(:final value)):
              return Eval.pure(
                IrNativeValue(
                  Value(
                    Navigator.of(
                      context,
                    ).pushNamed(value, arguments: IrObject(args)),
                  ),
                ),
              );
            default:
              break;
          }

        default:
          return throwError(
            wrongArgumentType(['Object with `route` required ']),
          );
      }
    }
    return Eval.pure(IrVoid());
  });
});
