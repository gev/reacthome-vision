import 'package:flow/make_flow_app.dart';
import 'package:flutter/widgets.dart';
import 'package:fvp/fvp.dart' as fvp;

void main() async {
  fvp.registerWith(
    options: {
      'lowLatency': 1,
      'decoders': ['V4L2:m2m', 'FFmpeg'],
    },
  );
  runApp(await makeFlowApp());
}
