import 'dart:async';

import 'package:common/bus/bus_emitter.dart';
import 'package:common/emitter.dart';

class Bus<T> {
  final _controller = StreamController<T>.broadcast();

  Emitter<T> get sink => BusEmitter(eventSink: _controller.sink);
  Stream<T> get stream => _controller.stream;

  void close() {
    _controller.close();
  }
}
