import 'package:vision/pub_sub/request.dart';
import 'package:vision/pub_sub/tracker.dart';

class Subscriber<K, V, T extends Tracker<K, V>> {
  final T tracker;
  final SubscribeRequest<K> _subscribe;

  Subscriber({required this.tracker, required this._subscribe});

  void subscribe(K key) {
    if (tracker.isNotTracked(key)) {
      _subscribe.subscribeOne(key);
    }
  }

  void reSubscribeAll() {
    if (tracker.isNotEmpty) {
      _subscribe.subscribeMany(tracker.keys);
    }
  }

  void publish(K key, V value) {
    if (tracker.isTracked(key)) {
      tracker.publish(key, value);
    }
  }
}

class DynamicSubscriber<K, V, T extends DynamicTracker<K, V>>
    extends Subscriber<K, V, T> {
  final UnsubscribeRequest<K> _unsubscribe;

  DynamicSubscriber({
    required super.tracker,
    required super.subscribe,
    required this._unsubscribe,
  });

  void unsubscribe(K key) {
    _unsubscribe.unsubscribeOne(key);
    tracker.untrack(key);
  }

  void unsubscribeAll() {
    _unsubscribe.unsubscribeMany(tracker.keys);
    tracker.untrackAll();
  }
}
