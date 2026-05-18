import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:vision/controllers/controller.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/retry/exponentional_backoff_policy.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class Scope {
  late final ResilientWebSocket _client;
  late final GlueEvaluator _evaluator;
  late final Controller _controller;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  Scope({required String host, required int port}) {
    final env = makeEnv(_outbound);
    _evaluator = GlueEvaluator(env);
    _controller = Controller(evaluator: _evaluator, source: _inbound.stream);
    _client = ResilientWebSocket(
      url: 'ws://$host:$port',
      sink: _inbound,
      policy: ExponentialBackoffPolicy(),
      source: _outbound.stream.map(
        (message) =>
            (BytesBuilder(copy: false)
                  ..addByte(1)
                  ..add(utf8.encode(message)))
                .takeBytes(),
      ),
    );
    _client.start();
  }

  ResilientWebSocket get client => _client;
  GlueEvaluator get evaluator => _evaluator;

  void dispose() {
    _client.dispose();
    _controller.dispose();
    _inbound.close();
    _outbound.close();
  }
}
