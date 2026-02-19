import 'package:common/bus/bus_listener.dart';
import 'package:flutter/widgets.dart';

abstract class ViewModel<E> extends BusListener<E> with ChangeNotifier {
  ViewModel({required super.eventSource});

  bool shouldNotify(E event);

  @override
  void handle(E event) {
    if (shouldNotify(event)) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    cancelSubscription();
    super.dispose();
  }
}
