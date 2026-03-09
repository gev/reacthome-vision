import 'package:flutter/material.dart';
import 'package:vision/widgets/screen.dart';

Route<T> makeRoute<T>(Widget widget) {
  return MaterialPageRoute(builder: (_) => Screen(body: widget));
}
