import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vision/controllers/glue_inbound_controller.dart';
import 'package:vision/controllers/glue_outbound_controller.dart';
import 'package:vision/uuid.dart';
import 'package:vision/vision_app.dart';
import 'package:vision/websocket/websocket_client.dart';

Widget makeLabApp() {
  final source = StreamController<Uint8List>();
  final sink = StreamController<String>();
  GlueInboundController(source.stream.map(utf8.decode));
  GlueOutboundController(sink);
  final client = WebSocketClient(
    url: 'ws://127.0.0.1:3005/${uuid()}',
    sink: source,
    source: sink.stream,
  );
  return VisionApp(title: 'Lab', client: client);
}
