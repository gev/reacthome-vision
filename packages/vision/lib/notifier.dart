import 'package:flutter/widgets.dart';
import 'package:vision/store/put.dart';

abstract interface class WriteNotifier<T> {
  void write(T newValue);
}

class WriteValueNotifier<T> extends ValueNotifier<T>
    implements WriteNotifier<T> {
  WriteValueNotifier(super.value);

  @override
  void write(T newValue) {
    value = newValue;
  }
}

class PutValueNotifier<K, T> extends ValueNotifier<T>
    implements WriteNotifier<T> {
  final K _key;
  final Put<K, T> _put;

  PutValueNotifier(super.value, {required this._key, required this._put});

  @override
  void write(T newValue) {
    _put.put(_key, newValue);
  }
}
