import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/stores/glue_reactive_cache.dart';
import 'package:vision/glue/stores/glue_reactive_db.dart';
import 'package:vision/glue/stores/glue_store.dart';
import 'package:vision/logger.dart';

class LocalPersistentStore implements GlueReactiveLookup {
  GlueDb? _local;
  GlueReactiveDb? _db;
  GlueReactiveCache? _cache;
  late final GlueReactiveLookup _lookup;

  LocalPersistentStore(Directory path, Logger log) {
    final local = makeGlueDb('local', path, log);
    if (local != null) {
      _local = local;
      final db = GlueReactiveDb(db: local, log: log);
      _db = db;
      _lookup = db;
    } else {
      log.warning('Fallback to temporary store');
      final cache = GlueReactiveCache();
      _cache = cache;
      _lookup = cache;
    }
  }

  @override
  ValueNotifier<Ir> lookup(String key, Ir defaultValue) =>
      _lookup.lookup(key, defaultValue);

  void dispose() {
    _cache?.dispose();
    _local?.dispose();
    _db?.dispose();
  }
}
