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
  final Map<String, String> _urls = {};

  @override
  Ir get value => IrList(_order.map((id) => _services[id]!).toList());

  String? url(String id) => _urls[id];

  void addService({
    required String id,
    required IrObject service,
    required String url,
  }) {
    _timers[id]?.cancel();
    _timers[id] = Timer(serviceTimeout, () {
      _removeService(id);
    });
    if (!_services.containsKey(id)) {
      _order.add(id);
    }
    _services[id] = service;
    _urls[id] = url;
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
