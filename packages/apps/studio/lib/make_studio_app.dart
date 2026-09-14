import 'package:flutter/material.dart';
import 'package:vision/mode/live/live_app.dart';

Future<Widget> makeStudioApp() =>
    makeLiveApp(title: 'Studio', host: '127.0.0.1', port: 3005);
