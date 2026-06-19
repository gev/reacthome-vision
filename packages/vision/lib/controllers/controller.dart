import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:vision/controllers/glue_controller.dart';

sealed class Header {
  static const heartbeat = 0, glue = 1, file = 2;
}

extension type Message(Uint8List message) {
  int get header => message[0];
  Uint8List get body => Uint8List.sublistView(message, 1);
}

class Controller {
  late final GlueController _glueController;
  late final StreamSubscription<Uint8List> _subscription;

  Controller({
    required GlueController glueController,
    required Stream<Uint8List> source,
  }) {
    _glueController = glueController;
    _subscription = source.listen(_onData);
  }

  void _onData(Uint8List data) {
    final message = Message(data);
    try {
      switch (message.header) {
        case Header.heartbeat:
          _handleHeartbeat();
        case Header.glue:
          _runGlue(message.body);
        case Header.file:
          _acceptFile(message.body);
        default:
          log("Unknown header: ${message.header}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _handleHeartbeat() {}

  void _runGlue(Uint8List body) {
    _glueController.runGlue(utf8.decode(body));
  }

  void _acceptFile(Uint8List body) {}

  void dispose() {
    _subscription.cancel();
  }
}
