import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/widgets/current_theme.dart';

final Ir imageColorScheme = IrNativeFunc(_imageColorSchemeImpl);

Eval<Ir> _imageColorSchemeImpl(Ir ir) {
  return getRuntime().bind((runtime) {
    switch (ir) {
      case IrObject(:final properties):
        final imageProvider = to<ImageProvider>(properties['provider']);
        if (imageProvider == null) {
          return throwError(
            wrongArgumentType(['Required ImageProvider as `provider`']),
          );
        }
        final context = getFromContext<BuildContext>(runtime.context);
        final notifier = context != null
            ? ValueNotifier(colorScheme(Theme.of(context).colorScheme))
            : ValueNotifier(IrVoid());
        ColorScheme.fromImageProvider(
          provider: imageProvider,
          brightness:
              to<Brightness>(properties['brightness']) ?? Brightness.light,
          dynamicSchemeVariant:
              to<DynamicSchemeVariant>(properties['dynamic-scheme-variant']) ??
              DynamicSchemeVariant.tonalSpot,
        ).then((cs) {
          notifier.value = colorScheme(cs);
        });
        return Eval.pure(IrNativeValue(Value(notifier)));

      default:
        return throwError(
          wrongArgumentType(['Required properties map with `provider`']),
        );
    }
  });
}
