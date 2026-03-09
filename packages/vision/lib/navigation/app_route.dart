import 'package:flutter/material.dart';

Route<T> makeRoute<T>(Widget widget) {
  return MaterialPageRoute(builder: (_) => widget);
}
