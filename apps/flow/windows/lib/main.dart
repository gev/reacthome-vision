import 'package:flow/make_flow_app.dart';
import 'package:flutter/widgets.dart';
import 'package:fvp/fvp.dart' as fvp;

void main() async {
  fvp.registerWith();
  runApp(await makeFlowApp());
}
