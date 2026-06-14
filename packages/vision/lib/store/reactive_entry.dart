import 'package:flutter/widgets.dart';
import 'package:vision/store/revision.dart';

class ReactiveEntry<P, V> {
  final ValueNotifier<P> notifier;
  V? _version;

  V? get version => _version;

  set value(Revision<P, V> value) {
    notifier.value = value.payload;
    _version = value.version;
  }

  ReactiveEntry(P value, [this._version]) : notifier = ValueNotifier(value);
}
