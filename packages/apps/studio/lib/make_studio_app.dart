import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/live/direct/direct_live_app.dart';

Future<Widget> makeStudioApp() =>
    makeDirectLiveApp(title: 'Studio', url: 'ws://127.0.0.1');
