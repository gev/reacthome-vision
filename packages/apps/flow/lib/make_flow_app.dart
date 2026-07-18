import 'package:flutter/material.dart';
import 'package:vision/main.dart';

Future<Widget> makeFlowApp() =>
    makeApp(title: 'Flow', host: '127.0.0.1', port: 3005);
