import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:vision/controllers/controller.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/store/glue_request.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/retry/exponentional_backoff_policy.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class Scope {
  late final ResilientWebSocket client;
  late final GlueEvaluator evaluator;
  late final Logger log;

  late final Controller _controller;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  Scope({required String host, required int port}) {
    log = Logger(sink: _outbound);
    final subsciber = Subscriber(request: GlueRequest(_outbound));
    final env = makeEnv(sink: _outbound, subscriber: subsciber, log: log);
    evaluator = GlueEvaluator(env: env, log: log);
    _controller = Controller(evaluator: evaluator, source: _inbound.stream);
    client = ResilientWebSocket(
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
    client.start();
  }

  void dispose() {
    client.dispose();
    _controller.dispose();
    _inbound.close();
    _outbound.close();
  }
}
