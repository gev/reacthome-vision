import 'package:flutter/widgets.dart';
import 'package:vision/stores/revision.dart';

class ReactiveEntry<P, V> {
  final ValueNotifier<P> notifier;
  V? _version;

  V? get version => _version;

  set value(Revision<P, V> value) {
    notifier.value = value.payload;
    _version = value.version;
  }

  ReactiveEntry(P value) : notifier = ValueNotifier(value);
}
