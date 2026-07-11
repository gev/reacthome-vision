import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';

/// Creates a Routes from an IrObject
final Ir app = IrNativeFunc(appImpl);

Eval<Ir> appImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final seedColor = to<Color>(properties['seed-color']);
      final dynamicSchemeVariant = to<DynamicSchemeVariant>(
        properties['dynamic-scheme-variant'],
      );
      switch (properties['routes']) {
        case IrObject(properties: final routes):
          return Eval.pure(
            IrNativeValue(
              Value(
                App(
                  seedColor: seedColor,
                  dynamicSchemeVariant: dynamicSchemeVariant,
                  routes: routes.unlock,
                ),
              ),
            ),
          );
        default:
          return throwError(wrongArgumentType(['Required routers map']));
      }
    default:
      return throwError(wrongArgumentType(['Required application propertis']));
  }
}

Eval<Ir> extractRoutes(IrObject routes) {
  final builders = <String, IrClosure>{};
  for (final route in routes.properties.entries) {
    switch (route.value) {
      case IrClosure builder:
        builders[route.key] = builder;
      default:
        return throwError(
          wrongArgumentType([
            'Route `${route.key}` should be a `lambda` accepted an `Object`',
          ]),
        );
    }
  }
  return Eval.pure(IrNativeValue(Value((routes: builders))));
}
