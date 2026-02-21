import 'package:flutter/widgets.dart';

class StateNotifier<T> extends ChangeNotifier {
  T _value;
  StateNotifier(this._value);

  T get value => _value;
  set value(T newValue) {
    _value = newValue;
    notifyListeners();
  }
}
