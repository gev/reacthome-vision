import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app_base_state.dart';
import 'package:vision/widgets/main_entry_point.dart';

class GlueNavigator extends StatefulWidget {
  final Ir app;

  const GlueNavigator({required this.app, super.key});

  @override
  State<GlueNavigator> createState() => _GlueNavigatorState();
}

class _GlueNavigatorState extends GlueAppBaseState<GlueNavigator> {
  @override
  Ir get app => widget.app;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: defaultRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
