import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

class HomeScreen extends StatelessWidget {
  final Runtime _runtime;
  final Logger _log;

  HomeScreen({required this._runtime, required this._log, super.key});

  // (
  //   (import screen.main)
  //   (main)
  // )
  final _main = IrList([
    IrList([IrSymbol('import'), IrDottedSymbol('screen.main')]),
    IrList([IrSymbol('main')]),
  ]);

  @override
  Widget build(BuildContext context) {
    return GlueWidget(expression: _main, runtime: _runtime, log: _log);
  }
}
