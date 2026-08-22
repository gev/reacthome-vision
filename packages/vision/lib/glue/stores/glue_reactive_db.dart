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
    final cached = _cache[key];
    if (cached != null) {
      return cached.notifier;
    }

    final entry = ReactiveEntry(defaultValue, 0);
    _db.lookup(key).then((value) {
      switch (value) {
        case Left(value: final error):
          _log.error(error);
        case Right(:final value):
          entry.value = value;
      }
    });
    _cache[key] = entry;
    return entry.notifier;
  }

  @override
  int? version(String key) {
    final cached = _cache[key];
    if (cached != null) {
      return cached.version;
    }
    return 0;
  }

  @override
  void put(String key, Revision<Ir, int> value) {
    final cached = _cache[key];
    if (cached != null) {
      cached.value = value;
    }
    _db.store(key, value).then((error) {
      if (error != null) {
        _log.error(error);
      }
    });
  }

  void dispose() {
    for (final entry in _cache.values) {
      entry.notifier.dispose();
    }
  }
}
