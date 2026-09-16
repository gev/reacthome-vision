import 'package:flutter/material.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/widgets/glue_navigator_base_state.dart';

class GlueNavigator extends StatefulWidget {
  final Routes routes;

  const GlueNavigator({required this.routes, super.key});

  @override
  State<GlueNavigator> createState() => _GlueNavigatorState();
}

class _GlueNavigatorState extends GlueNavigatorBaseState<GlueNavigator> {
  @override
  Routes get routes => widget.routes;

  @override
  Widget build(BuildContext context) {
    return Navigator(initialRoute: 'index', onGenerateRoute: generateRoute);
  }
}
