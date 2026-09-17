import 'package:flutter/material.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/widgets/glue_navigator_base_state.dart';
import 'package:vision/widgets/main_entry_point.dart';

class GlueNavigator extends StatefulWidget {
  final Routes routes;
  final Key? navigatorKey;

  const GlueNavigator({required this.routes, this.navigatorKey, super.key});

  @override
  State<GlueNavigator> createState() => _GlueNavigatorState();
}

class _GlueNavigatorState extends GlueNavigatorBaseState<GlueNavigator> {
  @override
  Routes get routes => widget.routes;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Navigator(
        key: widget.navigatorKey,
        initialRoute: defaultRoute,
        observers: [HeroController()],
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
