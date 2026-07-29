import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir locale = IrEvaluable(() {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context == null) {
      return Eval.pure(IrObject({}));
    }
    final locale = Localizations.localeOf(context);
    return Eval.pure(
      IrObject({
        'language-code': toIr(locale.languageCode),
        'country-code': toIr(locale.countryCode),
        'script-code': toIr(locale.scriptCode),
        'code': toIr(locale.toString()),
      }),
    );
  });
});
