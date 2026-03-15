import 'dart:async';

import 'package:vision/controllers/glue_controller.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/store/pool.dart';
import 'package:vision/websocket/websocket_client.dart';

class Scope {
  late final WebSocketClient _client;
  late final GlueEvaluator _evaluator;
  late final GlueController _controller;

  final _pool = Pool<String>();
  final _inbound = StreamController<String>();
  final _outbound = StreamController<String>();

  Scope({required String host, required int port}) {
    final env = makeEnv(_outbound, _pool);
    _evaluator = GlueEvaluator(env);
    _controller = GlueController(
      evaluator: _evaluator,
      source: _inbound.stream,
    );
    _client = WebSocketClient(
      url: 'ws://$host:$port',
      sink: _inbound,
      source: _outbound.stream,
      pool: _pool,
    );
  }

  WebSocketClient get client => _client;
  GlueEvaluator get evaluator => _evaluator;

  void dispose() {
    _client.dispose();
    _controller.dispose();
    _inbound.close();
    _outbound.close();
  }
}
