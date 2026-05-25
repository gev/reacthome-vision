import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';
import 'package:vision/widgets/empty_widget.dart';

class GlueWidget extends StatelessWidget {
  final String glue;

  const GlueWidget({required this.glue, super.key});

  @override
  Widget build(BuildContext context) {
    final scope = Scope.of(context);
    return FutureBuilder<Ir?>(
      initialData: IrNativeValue(Value(EmptyWidget())),
      future: scope.evaluator.evaluate(glue),
      builder: (context, snapshot) {
        final value = snapshot.requireData;
        final widget = value != null ? extractWidget(value) : null;
        if (widget == null) {
          scope.log.error("$glue \n Widget requered");
          return SizedBox.shrink();
        }
        return widget;
      },
    );
  }
}
