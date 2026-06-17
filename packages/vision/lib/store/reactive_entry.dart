import 'package:flutter/widgets.dart';
import 'package:vision/store/revision.dart';

class ReactiveEntry<P, V> extends ChangeNotifier {
  P? _;
  V? _version;

  V? get version => _version;

  set vesion(V v) {
    _version = v;
    notifier.notifyListeners();
  }

  set value(Revision<P, V> value) {
    notifier.value = value.payload;
    _version = value.version;
  }

  ReactiveEntry(P value, [this._version]) : notifier = ValueNotifier(value);
}
