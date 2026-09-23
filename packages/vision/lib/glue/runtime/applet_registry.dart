import 'package:flutter/widgets.dart';

class AppletRegistry {
  AppletRegistry._();

  static final Map<String, Widget> _pool = {};

  static Widget registerApplet(String id, Widget Function() makeApplet) {
    var widget = _pool[id];
    if (widget == null) {
      widget = makeApplet();
      _pool[id] = widget;
    }
    return widget;
  }
}
