import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';

class App {
  final Key? navigatorKey;
  final Color? seedColor;
  final DynamicSchemeVariant? dynamicSchemeVariant;
  final Routes routes;
  const App({
    this.navigatorKey,
    this.seedColor,
    this.dynamicSchemeVariant,
    required this.routes,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is App &&
        navigatorKey == other.navigatorKey &&
        seedColor == other.seedColor &&
        dynamicSchemeVariant == other.dynamicSchemeVariant;
  }

  @override
  int get hashCode =>
      Object.hash(navigatorKey, seedColor, dynamicSchemeVariant);
}

App defaultApp = App(routes: {});

typedef Routes = Map<String, Ir>;

typedef RouteEntry = ({
  String route,
  NavigatorState? targetNavigator,
  IrObject args,
});

Eval<RouteEntry> evalRoute(Ir ir) {
  if (ir case IrObject(:final properties)) {
    Ir? route;
    Ir? targetNavigator;
    final args = <String, Ir>{};
    for (final entry in properties.entries) {
      switch (entry.key) {
        case 'route':
          route = entry.value;
        case 'target':
          targetNavigator = entry.value;
        default:
          args[entry.key] = entry.value;
      }
    }
    if (route case IrSymbol(:final value)) {
      return Eval.pure((
        route: value,
        targetNavigator: extractFromGlobalKey(targetNavigator),
        args: IrObject(args),
      ));
    }
  }
  return throwError(wrongArgumentType(['Object with `route` required ']));
}

Eval<Ir> routeResult<T>(Future<T?> res) => Eval.pure(IrNativeValue(Value(res)));
