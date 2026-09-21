import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';

class DiscoveryStore extends ValueNotifier<Ir> {
  DiscoveryStore({this.serviceTimeout = const Duration(seconds: 15)})
    : super(IrList([]));

  final Duration serviceTimeout;
  final Map<String, IrObject> _services = {};
  final Map<String, Timer> _timers = {};
  final List<String> _order = [];

  @override
  Ir get value => IrList(_order.map((id) => _services[id]!).toList());

  void addService(String id, IrObject service) {
    _timers[id]?.cancel();
    _timers[id] = Timer(serviceTimeout, () {
      _removeService(id);
    });
    _services[id] = service;
    if (!_services.containsKey(id)) {
      _order.add(id);
    }
    notifyListeners();
  }

  void _removeService(String id) {
    _timers[id]?.cancel();
    _timers.remove(id);
    if (_services.remove(id) != null) {
      _order.remove(id);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}
