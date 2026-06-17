import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:vision/store/lookup.dart';
import 'package:vision/store/reactive_entry.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/store/version.dart';

class Assets implements ReactiveLookup<String, String>, Version<String, int> {
  final Directory _path;

  final Map<String, ReactiveEntry<String, int>> _cache = {};

  Assets({required this._path}) {
    _path.createSync(recursive: true);
  }

  @override
  ValueNotifier<String> lookup(String name, String defaultValue) {
    var entry = _cache[name];
    if (entry == null) {
      final asset = p.join(_path.path, name);
      final stat = FileStat.statSync(asset);
      if (stat.type != FileSystemEntityType.notFound) {
        final version = stat.modified.millisecondsSinceEpoch;
        entry = ReactiveEntry(asset, version);
      } else {
        entry = ReactiveEntry(defaultValue);
      }
      _cache[name] = entry;
    }
    return entry.notifier;
  }

  @override
  int? version(String name) {
    var entry = _cache[name];
    if (entry == null) {
      final asset = p.join(_path.path, name);
      final stat = FileStat.statSync(asset);
      if (stat.type != FileSystemEntityType.notFound) {
        final version = stat.modified.millisecondsSinceEpoch;
        entry = ReactiveEntry(asset, version);
        _cache[name] = entry;
        return version;
      } else {
        return 0;
      }
    }
    return entry.version;
  }

  Future<Object?> complete(String name, int miliseconds) async {
    try {
      final entry = _cache[name];
      if (entry != null) {
        final asset = p.join(_path.path, name);
        final tmp = File(p.setExtension(asset, '.tmp'));
        if (await tmp.exists()) {
          final dst = File(asset);
          if (await dst.exists()) {
            await dst.delete();
          }
          final file = await tmp.rename(asset);
          await file.setLastAccessed(
            DateTime.fromMillisecondsSinceEpoch(miliseconds),
          );
          entry.value = (payload: asset, version: miliseconds);
        }
      }
    } catch (error) {
      return error;
    }
    return null;
  }

  Future<Object?> write(String name, List<int> buffer, int offset) async {
    try {
      final entry = _cache[name];
      if (entry != null) {
        final asset = p.join(_path.path, name);
        final file = File(p.setExtension(asset, '.tmp'));
        await file
            .open(mode: FileMode.writeOnly)
            .then((tmp) => tmp.setPosition(offset))
            .then((tmp) => tmp.writeFrom(buffer))
            .then((tmp) => tmp.close());
      }
    } catch (error) {
      return error;
    }
    return null;
  }
}
