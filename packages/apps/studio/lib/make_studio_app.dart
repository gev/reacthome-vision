import 'package:flutter/material.dart';
import 'package:vision/mode/live/live_app.dart';

Future<Widget> makeStudioApp() =>
    makeLiveApp(title: 'Studio', url: 'ws://127.0.0.1');
