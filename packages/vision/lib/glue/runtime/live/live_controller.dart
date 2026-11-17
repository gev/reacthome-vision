import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:glue/ir.dart';
import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/runtime/live/assets_controller.dart';
import 'package:vision/glue/runtime/reactive_runtime.dart';
import 'package:vision/widgets/entry_point.dart';

sealed class Header {
  static const heartbeat = 0, glue = 1, file = 2;
}

extension type Message(Uint8List message) {
  int get header => message[0];
  Uint8List get body => Uint8List.sublistView(message, 1);
}

class LiveController {
  final GlueController _glueController;
  final AssetsController _assetsController;
  final ReactiveRuntime _reactiveRuntime;
  final void Function() _resubscribe;

  late final StreamSubscription<Uint8List> _subscription;

  int? _hid;

  LiveController({
    required this._glueController,
    required this._assetsController,
    required this._reactiveRuntime,
    required this._resubscribe,
    required Stream<Uint8List> source,
  }) {
    _subscription = source.listen(_onData);
  }

  void _onData(Uint8List data) {
    final message = Message(data);
    print(data);
    try {
      switch (message.header) {
        case Header.heartbeat:
          _handleHeartbeat(message.body);
        case Header.glue:
          _handleGlue(message.body);
        case Header.file:
          _assetsController.acceptAsset(message.body);
        default:
          log("Unknown header: ${message.header}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _handleHeartbeat(Uint8List data) {
    final hid = data.buffer.asByteData().getInt32(0, Endian.big);
    print(hid);
    if (_hid == hid) return;
    print("Resubscribing to live updates");
    _resubscribe();
    _hid = hid;
  }

  void _handleGlue(Uint8List data) {
    final endpoint = _glueController.compileGlue(data);
    if (endpoint case IrList(:final elements)) {
      switch (elements.unlock) {
        case [IrSymbol(value: 'put'), ...]:
          _glueController.evalGlue(endpoint, _reactiveRuntime.runtime);
        default:
          final code = apiEndpoint(endpoint);
          _glueController.evalGlue(code, _reactiveRuntime.runtime);
      }
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
