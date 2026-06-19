import 'package:vision/pub_sub/request.dart';
import 'package:vision/store/put.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/store/version.dart';

class _Subscription<K, T, V extends Comparable> {
  V? version;
  final Set<Put<K, T>> putStores;

  _Subscription(this.version, Put<K, T> store) : putStores = {store};

  bool rememberVersion(V incomingVersion) {
    if (version == null || incomingVersion.compareTo(version) > 0) {
      version = incomingVersion;
      return true;
    }
    return false;
  }

  void mergeVersion(V? incomingVersion) {
    if (incomingVersion != null) {
      rememberVersion(incomingVersion);
    }
  }
}

class Subscriber<K, P, V extends Comparable> {
  final Map<K, _Subscription<K, Revision<P, V>, V>> _subscriptions = {};
  final Request<K, V> _request;

  Subscriber({required this._request});

  void subscribe(
    K key,
    Version<K, V> verStore,
    Put<K, Revision<P, V>> putStore,
  ) {
    var subscription = _subscriptions[key];
    final version = verStore.version(key);
    if (subscription == null) {
      _subscriptions[key] = _Subscription(version, putStore);
      _request.subscribeOne((key: key, version: version));
    } else {
      subscription
        ..mergeVersion(version)
        ..putStores.add(putStore);
    }
  }

  void resubscribeAll() {
    _request.subscribeMany(
      _subscriptions.entries.map(
        (entry) => (key: entry.key, version: entry.value.version),
      ),
    );
  }

  void publish(K key, Revision<P, V> value) {
    final subscription = _subscriptions[key];
    if (subscription != null) {
      if (subscription.rememberVersion(value.version)) {
        for (final store in subscription.putStores) {
          store.put(key, value);
        }
      }
    }
  }
}
