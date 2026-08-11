import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

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
        final brightness = to<Brightness>(properties['brightness']);
        final context = getFromContext<BuildContext>(runtime.context);
        final notifier = context != null
            ? ValueNotifier(Theme.of(context).colorScheme)
            : ValueNotifier(null);
        ColorScheme.fromImageProvider(
          provider: imageProvider,
          brightness: brightness ?? Brightness.light,
        ).then((colorScheme) {
          notifier.value = colorScheme;
        });
        return Eval.pure(IrNativeValue(Value(notifier)));

      default:
        return throwError(
          wrongArgumentType(['Required properties map with `provider`']),
        );
    }
  });
}
