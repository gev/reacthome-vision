import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/glue_reactive_cache.dart';
import 'package:vision/glue/stores/glue_subscribable.dart';

class TmpStore implements GlueSubscribable {
  late final GlueReactiveCache _store;
  late final GlueSubscribable _subscribable;

  TmpStore(GlueSubscriber subscriber) {
    _store = GlueReactiveCache();
    _subscribable = GlueSubscribable(
      subscriber: subscriber,
      lookupStore: _store,
      versionStore: _store,
      putStore: _store,
    );
  }

  @override
  ValueNotifier<Ir> lookup(String key, Ir defaultValue) =>
      _subscribable.lookup(key, defaultValue);

  void dispose() {
    _store.dispose();
  }
}
