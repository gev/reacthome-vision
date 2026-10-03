import 'package:flow/make_flow_app.dart';
import 'package:flutter/widgets.dart';
import 'package:fvp/fvp.dart' as fvp;

void main() async {
  fvp.registerWith(
    options: {
      'platforms': ['linux'],
      'video.decoders': ['V4L2M2M'],
      'lowLatency': 2,
      'global': {'logLevel': 'All'},
    },
  );
  runApp(await makeFlowApp());
}
