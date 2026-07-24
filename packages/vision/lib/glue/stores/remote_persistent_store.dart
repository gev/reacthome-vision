import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/glue_reactive_cache.dart';
import 'package:vision/glue/stores/glue_reactive_db.dart';
import 'package:vision/glue/stores/glue_subscribable.dart';
import 'package:vision/logger.dart';
import 'package:vision/store/subscribable.dart';

class RemotePersistentStore implements GlueSubscribable {
  GlueDb? _remote;
  GlueReactiveDb? _db;
  GlueReactiveCache? _cache;

  late final GlueSubscribable _subscribable;

  RemotePersistentStore(Directory path, GlueSubscriber subscriber, Logger log) {
    final remote = makeGlueDb('remote', path, log);
    if (remote != null) {
      _remote = remote;
      final db = GlueReactiveDb(db: remote, log: log);
      _db = db;
      _subscribable = ReactiveSubscribable(
        subscriber: subscriber,
        lookupStore: db,
        versionStore: db,
        putStore: db,
      );
    } else {
      log.warning('Fallback to temporary store');
      final cache = GlueReactiveCache();
      _cache = cache;
      _subscribable = ReactiveSubscribable(
        subscriber: subscriber,
        lookupStore: cache,
        versionStore: cache,
        putStore: cache,
      );
    }
  }

  @override
  ValueNotifier<Ir> lookup(String key, Ir defaultValue) =>
      _subscribable.lookup(key, defaultValue);

  void dispose() {
    _cache?.dispose();
    _remote?.dispose();
    _db?.dispose();
  }
}
