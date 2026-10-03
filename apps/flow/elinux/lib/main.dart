import 'package:flow/make_flow_app.dart';
import 'package:flutter/widgets.dart';
import 'package:fvp/fvp.dart' as fvp;

void main() async {
  fvp.registerWith(
    options: {
      'platforms': ['linux'],
      'video.decoders': ['V4L2M2M'],
      'lowLatency': 1,
      'maxWidth': 1920,
      'maxHeight': 1080,
    },
  );
  runApp(await makeFlowApp());
}
