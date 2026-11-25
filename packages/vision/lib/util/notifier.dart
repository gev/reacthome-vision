import 'package:flutter/widgets.dart';

class WriteNotifier<T> extends ValueNotifier<T> {
  final ValueNotifier<T> _notifier;
  final void Function(T newValue) _write;

  WriteNotifier.wrap(this._notifier, this._write) : super(_notifier.value);

  @override
  T get value => _notifier.value;

  @override
  set value(T newValue) {
    _notifier.value = newValue;
  }

  @override
  bool get hasListeners => _notifier.hasListeners;

  @override
  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    _notifier.dispose();
  }

  void write(T newValue) {
    _write(newValue);
  }
}
