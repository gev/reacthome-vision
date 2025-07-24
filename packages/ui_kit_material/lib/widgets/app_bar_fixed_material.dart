import 'package:flutter/material.dart';

class AppBarFixedMaterial extends AppBar {
  AppBarFixedMaterial({required String title, Widget? trailing, super.key})
    : super(title: Text(title), actions: trailing != null ? [trailing] : []);
}
