import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';

class MultiNavigatorTracker extends NavigatorObserver {
  static final Expando<List<Route>> _histories = Expando<List<Route>>();

  List<Route> get _currentHistory {
    final nav = navigator;
    if (nav == null) return [];
    var history = _histories[nav];
    if (history == null) {
      history = [];
      _histories[nav] = history;
    }
    return history;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _currentHistory.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _currentHistory.remove(route);
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _currentHistory.remove(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) _currentHistory.remove(oldRoute);
    if (newRoute != null) _currentHistory.add(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  static Route? findExistingRoute(
    NavigatorState navigator,
    String name,
    IrObject? args,
  ) {
    final history = _histories[navigator];
    if (history == null) return null;

    for (final r in history) {
      if (r.settings.name == name && r.settings.arguments == args) {
        return r;
      }
    }
    return null;
  }
}
