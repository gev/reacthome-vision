import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // (
  //   (import main)
  //   (main)
  // )
  final _main = IrList([
    IrList([IrSymbol('import'), IrSymbol('main')]),
    IrList([IrSymbol('main')]),
  ]);

  @override
  Widget build(BuildContext context) {
    return GlueWidget(expression: _main);
  }
}
