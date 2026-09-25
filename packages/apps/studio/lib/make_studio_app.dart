import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/live/live_app.dart';

Future<Widget> makeStudioApp() =>
    makeLiveApp(title: 'Studio', getUrl: () => 'ws://127.0.0.1');
