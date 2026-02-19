// ignore_for_file: unused_field

import 'dart:async';

import 'package:common/handler.dart';

abstract class ChannelListener<E> extends Object implements Handler<E> {
  late StreamSubscription<E> _subscription;

  ChannelListener({required Stream<E> eventSource}) {
    _subscription = eventSource.listen(handle);
  }

  void cancelSubscription() => _subscription.cancel();
}
