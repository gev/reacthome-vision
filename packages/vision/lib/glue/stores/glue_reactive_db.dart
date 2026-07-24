import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/stores/glue_store.dart';
import 'package:vision/logger.dart';
import 'package:vision/store/reactive_entry.dart';
import 'package:vision/store/revision.dart';

class GlueReactiveDb implements GlueReactiveLookup, GlueVersion, GluePut {
  final GlueDb _db;
  final Logger _log;

  final Map<String, ReactiveEntry<Ir, int>> _cache = {};

  GlueReactiveDb({required this._db, required this._log});

  @override
  ValueNotifier<Ir> lookup(String key, Ir defaultValue) {
    var entry = _cache[key];
    if (entry == null) {
      switch (_db.lookup(key)) {
        case Left(value: final error):
          entry = ReactiveEntry(defaultValue);
          _log.error(error);
        case Right(:final value):
          entry = ReactiveEntry(value.payload, value.version);
      }
      _cache[key] = entry;
    }
    return entry.notifier;
  }

  @override
  int? version(String key) {
    var entry = _cache[key];
    if (entry == null) {
      switch (_db.lookup(key)) {
        case Left(value: final error):
          _log.error(error);
        case Right(:final value):
          entry = ReactiveEntry(value.payload, value.version);
          _cache[key] = entry;
          return entry.version;
      }
    }
    return 0;
  }

  @override
  void put(String key, Revision<Ir, int> value) {
    final entry = _cache[key];
    if (entry != null) {
      entry.value = value;
    }
    final error = _db.store(key, value);
    if (error != null) {
      _log.error(error);
    }
  }

  void dispose() {
    for (final entry in _cache.values) {
      entry.notifier.dispose();
    }
  }
}
