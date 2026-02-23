import 'package:flutter/material.dart';
import 'package:glue/compile.dart';
import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';
import 'package:vision/glue/env.dart';

typedef GlueEvalResult = Either<GlueError, List<Widget>>;

/// Service for evaluating Glue code and converting results to Flutter widgets
class GlueEvaluator {
  /// Evaluate Glue code and return either widgets or a Glue error
  static Future<GlueEvalResult> evaluateCode(String code) async {
    final parseResult = parseGlue(code);
    return parseResult.match(
      (parseError) {
        return Left(parseError);
      },
      (ast) async {
        final irTree = compile(ast);
        final evalResult = await runEvalSimple(eval(irTree), env);
        return evalResult.match(
          (error) {
            return Left(error);
          },
          (value) {
            final (resultIr, _) = value;
            final widgets = _extractWidgetsFromIr(resultIr, []);
            return Right(widgets);
          },
        );
      },
    );
  }

  /// Extract flattened list of Flutter widgets from Glue IR evaluation result
  static List<Widget> _extractWidgetsFromIr(Ir ir, List<Widget> accum) {
    switch (ir) {
      case IrNativeValue(value: final hostValue):
        switch (hostValue.value) {
          case Widget widget:
            accum.add(widget);
          default:
            accum.add(
              Container(
                padding: const EdgeInsets.all(16),
                child: Text('Result: ${hostValue.value}'),
              ),
            );
        }
      case IrString(value: final value):
        accum.add(Text(value));
      case IrInteger(value: final value):
        accum.add(Text(value.toString()));
      case IrFloat(value: final value):
        accum.add(Text(value.toString()));
      case IrBool(value: final value):
        accum.add(Text(value.toString()));
      case IrList(:final elements):
        for (final element in elements) {
          _extractWidgetsFromIr(element, accum); // Recursive flattening
        }
      case IrVoid():
        break; // Ignore void values - don't add anything
      default:
        accum.add(
          Container(
            padding: const EdgeInsets.all(16),
            child: Text('Glue Result: ${ir.toString()}'),
          ),
        );
    }
    return accum;
  }
}
