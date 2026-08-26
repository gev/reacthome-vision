import 'package:flutter/material.dart';
import 'package:vision/mode/live/live_app.dart';

Future<Widget> makeFlowApp() =>
    makeLiveApp(title: 'Flow', host: '192.168.11.101', port: 3005);
