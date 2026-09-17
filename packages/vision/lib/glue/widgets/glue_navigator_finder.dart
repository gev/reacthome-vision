import 'package:flutter/widgets.dart';
import 'package:vision/glue/widgets/glue_navigator_base_state.dart';

/// Base helper for traversing up the ancestor tree to find a matching Glue navigator state.
/// Accepts a [test] predicate to determine if the found state is the desired one.
GlueNavigatorBaseState? _findGlueNavigator(
  BuildContext context,
  bool Function(GlueNavigatorBaseState state) test,
) {
  GlueNavigatorBaseState? result;
  context.visitAncestorElements((element) {
    if (element is StatefulElement && element.state is GlueNavigatorBaseState) {
      final state = element.state as GlueNavigatorBaseState;
      if (test(state)) {
        result = state;
        return false; // Stop searching once found
      }
    }
    return true; // Continue climbing up the tree
  });
  return result;
}

/// Finds the target [NavigatorState] whose route map contains the [routeKey],
/// or falls back to the nearest [NavigatorState] in the widget tree.
NavigatorState findTargetNavigator(BuildContext context, String routeKey) {
  final targetState = _findGlueNavigator(
    context,
    (state) => state.routes.containsKey(routeKey),
  );

  return targetState?.navigatorKey.currentState ?? Navigator.of(context);
}

/// Checks whether a pop action can be performed on any Glue navigator or standard stack.
bool canPopNavigator(BuildContext context) {
  final hasGlueNavigatorToPop =
      _findGlueNavigator(
        context,
        (state) => state.navigatorKey.currentState?.canPop() == true,
      ) !=
      null;

  if (hasGlueNavigatorToPop) {
    return true;
  }

  return Navigator.of(context).canPop();
}

/// Finds the specific [NavigatorState] for performing a pop operation,
/// sequentially checking local Glue levels, the root navigator, and a standard fallback.
NavigatorState? findNavigatorToPop(BuildContext context) {
  // 1. Find the nearest Glue navigator that can actually perform a pop
  final targetState = _findGlueNavigator(
    context,
    (state) => state.navigatorKey.currentState?.canPop() == true,
  );

  if (targetState != null) {
    return targetState.navigatorKey.currentState;
  }

  // 2. If local levels are exhausted, check the root application navigator
  final rootNav = Navigator.of(context, rootNavigator: true);
  if (rootNav.canPop()) {
    return rootNav;
  }

  // 3. Final fallback to the standard context navigator
  final localNav = Navigator.of(context);
  return localNav.canPop() ? localNav : null;
}
