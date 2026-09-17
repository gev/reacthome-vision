import 'package:flutter/widgets.dart';
import 'package:vision/glue/widgets/glue_navigator_base_state.dart';

/// Finds the target [NavigatorState] whose route map contains the [routeKey],
/// or falls back to the nearest [NavigatorState] in the widget tree.
NavigatorState findTargetNavigator(BuildContext context, String routeKey) {
  GlueNavigatorBaseState? targetNavigatorState;

  context.visitAncestorElements((element) {
    if (element is StatefulElement && element.state is GlueNavigatorBaseState) {
      final state = element.state as GlueNavigatorBaseState;
      if (state.routes.containsKey(routeKey)) {
        targetNavigatorState = state;
        return false; // Stop searching once found
      }
    }
    return true; // Continue climbing up the tree
  });

  return targetNavigatorState?.navigatorKey.currentState ??
      Navigator.of(context);
}
