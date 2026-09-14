import 'package:flutter/material.dart';
import 'package:vision/mode/live/live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeFlowApp() {
  return makeLiveScope(
    host: '192.168.11.101',
    port: 3005,
    child: VisionApp(title: 'Flow'),
  );
}
