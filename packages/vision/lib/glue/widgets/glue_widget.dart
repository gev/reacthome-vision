import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/widgets/empty_widget.dart';
import 'package:vision/widgets/vision_scope.dart';

class GlueWidget extends StatelessWidget {
  final String glue;

  const GlueWidget({required this.glue, super.key});

  @override
  Widget build(BuildContext context) {
    final evaluator = VisionScope.of(context).evaluator;
    return FutureBuilder<Either<GlueError, Ir>>(
      initialData: Right(IrNativeValue(Value(EmptyWidget()))),
      future: evaluator.evaluate(glue),
      builder: (context, snapshot) {
        return snapshot.requireData.match(
          (error) => Text('Error: $error'),
          (value) => extractWidget(value),
        );
      },
    );
  }
}
