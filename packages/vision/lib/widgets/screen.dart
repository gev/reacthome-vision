import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget? _body;
  final PreferredSizeWidget? _appBar;

  const Screen({this._body, this._appBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar ?? AppBar(), body: _body);
  }
}
