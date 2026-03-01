import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:vision/controllers/glue_controller.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/widgets/vision_app.dart';

Widget makeApp({
  required String id,
  required String title,
  required String host,
  required int port,
}) {
  final source = StreamController<Uint8List>();
  final sink = StreamController<String>();
  GlueController(sink: sink, source: source.stream.map(utf8.decode));
  final client = WebSocketClient(
    url: 'ws://$host:$port/$id',
    sink: source,
    source: sink.stream,
  );
  return VisionApp(title: title, client: client);
}
