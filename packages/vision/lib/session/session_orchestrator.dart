import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:glue/env.dart';
import 'package:vision/controllers/controller.dart';
import 'package:vision/glue/env.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_request.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/retry/exponentinal_backoff_policy.dart';
import 'package:vision/session/session_monitor.dart';
import 'package:vision/session/session_state.dart';
import 'package:vision/websocket/resilient_websocket.dart';

class SessionOrchestrator {
  final monitor = SessionMonitor();
  late final GlueEvaluator evaluator;
  late final Env env;

  late final Logger log;
  late final Controller _controller;
  late final GlueSubscriber _subscriber;

  final _inbound = StreamController<Uint8List>();
  final _outbound = StreamController<String>();

  SessionOrchestrator({required String host, required int port}) {
    _subscriber = GlueSubscriber(subscribe: GlueRequest(_outbound));
    log = Logger(sink: _outbound);
    final env = makeEnv(sink: _outbound, subscriber: _subscriber, log: log);
    evaluator = GlueEvaluator(env: env, log: log);
    _controller = Controller(evaluator: evaluator, source: _inbound.stream);
    final client = _resilientWebSocket('ws://$host:$port');
    client.start();
  }

  ResilientWebSocket _resilientWebSocket(String url) => ResilientWebSocket(
    url: url,
    sink: _inbound,
    policy: ExponentialBackoffPolicy(),
    source: _outbound.stream.map(
      (message) =>
          (BytesBuilder(copy: false)
                ..addByte(1)
                ..add(utf8.encode(message)))
              .takeBytes(),
    ),
    onStateChange: _onStateChange,
  );

  void _onStateChange(SessionState newState) {
    monitor.state = newState;
    if (newState == .connected) {
      _subscriber.reSubscribeAll();
    }
  }

  void dispose() {
    monitor.dispose();
    _controller.dispose();
    _inbound.close();
    _outbound.close();
  }
}
