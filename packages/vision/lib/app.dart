import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:vision/controllers/glue_controller.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/widgets/vision_app.dart';
import 'package:vision/widgets/vision_scope.dart';

Widget makeApp({
  required String id,
  required String title,
  required String host,
  required int port,
}) {
  final source = StreamController<String>();
  final sink = StreamController<String>();
  final evaluator = GlueEvaluator(makeEnv(sink));
  GlueController(evaluator: evaluator, source: source.stream);
  final client = WebSocketClient(
    url: 'ws://$host:$port/$id',
    sink: source,
    source: sink.stream,
  );
  return VisionScope(
    client: client,
    evaluator: evaluator,
    child: VisionApp(title: title),
  );
}
