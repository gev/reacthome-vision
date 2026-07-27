import 'package:flutter/widgets.dart';
import 'package:vision/store/put.dart';

abstract interface class Write<T> {
  void write(T newValue);
}

class State<T> extends ChangeNotifier {
  T _value;

  State(this._value);

  T get value => _value;

  set value(T value) {
    if (_value != value) {
      _value = value;
      notifyListeners();
    }
  }
}

class WriteState<T> extends State<T> implements Write<T> {
  WriteState(super.value);

  @override
  void write(T newValue) {
    value = newValue;
  }
}

class PutState<K, T> extends State<T> implements Write<T> {
  final K _key;
  final Put<K, T> _put;

  PutState(super.value, {required this._key, required this._put});

  @override
  void write(T newValue) {
    _put.put(_key, newValue);
  }
}
