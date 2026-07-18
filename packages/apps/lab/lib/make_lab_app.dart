import 'package:flutter/material.dart';
import 'package:vision/main.dart';

Future<Widget> makeLabApp() =>
    makeApp(title: 'Lab', host: '192.168.11.210', port: 3005);
