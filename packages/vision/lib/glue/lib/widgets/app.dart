import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

/// Creates a Routes from an IrObject
final Ir app = IrSpecial(
  (List<Ir> ir) => getEnv().bind((env) {
    switch (ir) {
      case [IrObject(:final properties)]:
        switch (properties['routes']) {
          case IrObject(properties: final routes):
            final builders = <String, RouteBuilder>{};
            for (final route in routes.entries) {
              builders[route.key] = (settings) {
                final args = toIr(settings.arguments);
                return (_) => GlueWidget(
                  expression: IrList([route.value, args]),
                  env: env,
                );
              };
            }
            return Eval.pure(IrNativeValue(Value((routes: builders))));
          default:
            return throwError(wrongArgumentType(['required routers map']));
        }
      default:
        return throwError(
          wrongArgumentType(['required application propertis']),
        );
    }
  }),
);
