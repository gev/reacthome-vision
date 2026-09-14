import 'package:flutter/material.dart';
import 'package:vision/mode/live/live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeStudioApp() => makeLiveScope(
  host: '127.0.0.1',
  port: 3005,
  child: VisionApp(title: 'Studio'),
);
