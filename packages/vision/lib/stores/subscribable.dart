import 'package:flutter/widgets.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/lookup.dart';
import 'package:vision/stores/put.dart';
import 'package:vision/stores/revision.dart';
import 'package:vision/stores/version.dart';

class Subscribable<K, P, V extends Comparable, R> implements Lookup<K, P, R> {
  final Subscriber<K, P, V> _subscriber;
  final Lookup<K, P, R> _lookupStore;
  final Version<K, V> _versionStore;
  final Put<K, Revision<P, V>> _putStore;

  const Subscribable({
    required this._subscriber,
    required this._lookupStore,
    required this._versionStore,
    required this._putStore,
  });

  @override
  R lookup(K key, P defaultValue) {
    _subscriber.subscribe(key, _versionStore, _putStore);
    return _lookupStore.lookup(key, defaultValue);
  }
}

typedef ReactiveSubscribable<K, P, V extends Comparable> =
    Subscribable<K, P, V, ValueNotifier<P>>;
