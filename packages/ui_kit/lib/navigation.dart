import 'package:flutter/widgets.dart';

abstract interface class Navigation {
  String get initialRoute;
  Map<String, WidgetBuilder> get routes;
}
