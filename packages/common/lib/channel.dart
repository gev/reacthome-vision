import 'dart:async';

class Channel<T> {
  final StreamController<T> _controller;
  Channel() : _controller = StreamController<T>();
  Channel.broadcast() : _controller = StreamController<T>.broadcast();

  Sink<T> get sink => _controller.sink;
  Stream<T> get source => _controller.stream;

  void close() {
    _controller.close();
  }
}
