import 'dart:async';

import 'package:common/channel/channel_emitter.dart';
import 'package:common/emitter.dart';

class BroadcastChannel<T> {
  final _controller = StreamController<T>.broadcast();

  Emitter<T> get sink => ChannelEmitter(eventSink: _controller.sink);
  Stream<T> get source => _controller.stream;

  void close() {
    _controller.close();
  }
}
