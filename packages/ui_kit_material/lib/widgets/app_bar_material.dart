import 'package:flutter/material.dart';

class AppBarMaterial extends AppBar {
  AppBarMaterial({required String title, Widget? trailing, super.key})
    : super(title: Text(title), actions: trailing != null ? [trailing] : []);
}
