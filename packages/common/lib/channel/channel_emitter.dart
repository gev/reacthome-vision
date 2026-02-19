import 'package:common/emitter.dart';

class ChannelEmitter<T> implements Emitter<T> {
  final Sink<T> eventSink;

  const ChannelEmitter({required this.eventSink});

  @override
  void emit(T event) => eventSink.add(event);
}
