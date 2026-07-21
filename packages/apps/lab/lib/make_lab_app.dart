import 'package:flutter/material.dart';
import 'package:vision/mode/live/live_app.dart';

Future<Widget> makeLabApp() =>
    makeLiveApp(title: 'Lab', host: '192.168.11.210', port: 3005);
