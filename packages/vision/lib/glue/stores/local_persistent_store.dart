import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/stores/glue_reactive_cache.dart';
import 'package:vision/glue/stores/glue_reactive_db.dart';
import 'package:vision/glue/stores/glue_store.dart';
import 'package:vision/logger.dart';
import 'package:vision/store/revision.dart';

class LocalPersistentStore implements GlueReactiveLookup, GluePut {
  GlueDb? _local;
  GlueReactiveDb? _db;
  GlueReactiveCache? _cache;
  late final GlueReactiveLookup _lookup;
  late final GluePut _put;

  LocalPersistentStore(Directory path, Logger log) {
    final local = makeGlueDb('local', path, log);
    if (local != null) {
      _local = local;
      final db = GlueReactiveDb(db: local, log: log);
      _db = db;
      _lookup = db;
      _put = db;
    } else {
      log.warning('Fallback to temporary store');
      final cache = GlueReactiveCache();
      _cache = cache;
      _lookup = cache;
      _put = cache;
    }
  }

  @override
  ValueNotifier<Ir> lookup(String key, Ir defaultValue) =>
      _lookup.lookup(key, defaultValue);

  @override
  void put(String key, Revision<Ir, int> value) {
    _put.put(key, value);
  }

  void dispose() {
    _cache?.dispose();
    _local?.dispose();
    _db?.dispose();
  }
}
