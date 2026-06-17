import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:vision/persistent/asset_request.dart';

typedef ReactiveAsset = ValueNotifier<String?>;
typedef Chunk = ({int index, int offset, List<int> buffer});
typedef OnError = void Function(Object error);

class _AssetEntry {
  final Set<int> chunks = {};
  final ReactiveAsset asset;
  bool isDownloading = false;

  _AssetEntry([String? name]) : asset = ValueNotifier(name);
}

class Assets {
  final Directory _path;
  final Directory _tmp;
  final AssetRequest _request;

  final Map<String, _AssetEntry> _cache = {};

  Assets({required this._path, required this._tmp, required this._request}) {
    _path.createSync(recursive: true);
    _tmp.deleteSync(recursive: true);
    _tmp.createSync(recursive: true);
  }

  ReactiveAsset lookup(String name) {
    var entry = _cache[name];
    if (entry == null) {
      final assetPath = _assetFilePath(name);
      final assetFile = File(assetPath);
      if (assetFile.existsSync()) {
        entry = _AssetEntry(assetPath);
      } else {
        entry = _AssetEntry();
        _request.one(name);
      }
      _cache[name] = entry;
    }
    return entry.asset;
  }

  void reRequestAll() {
    final spec = <String>[];
    for (final entry in _cache.entries) {
      final assetFile = File(_assetFilePath(entry.key));
      if (!assetFile.existsSync()) {
        spec.add(entry.key);
        entry.value.isDownloading = false;
      }
    }
    _request.many(spec);
  }

  void start({
    required String name,
    required int size,
    required int tottal,
    required Stream<Chunk> source,
    required OnError onError,
  }) async {
    final entry = _cache[name];
    if (entry == null || entry.isDownloading) return;

    final assetPath = _assetFilePath(name);

    final assetFile = File(assetPath);
    if (await assetFile.exists()) return;

    entry.isDownloading = true;

    final tmpFile = File(_tmpFilePath(name));

    entry.chunks.clear();
    try {
      final accessFile = await tmpFile.open(mode: FileMode.writeOnly);

      try {
        await accessFile.truncate(size);
        await for (final chunk in source) {
          if (!entry.isDownloading) break;
          await accessFile.setPosition(chunk.offset);
          await accessFile.writeFrom(chunk.buffer);
          entry.chunks.add(chunk.index);
        }
      } finally {
        await accessFile.close();
      }

      if (entry.chunks.length != tottal) {
        throw StateError(
          'Stream closed prematurely: received ${entry.chunks.length} out of $tottal chunks.',
        );
      }

      await tmpFile.rename(assetPath);
      entry.asset.value = assetPath;
    } catch (error) {
      try {
        await tmpFile.delete();
      } finally {
        onError(error);
      }
    } finally {
      entry.isDownloading = false;
    }
  }

  String _tmpFilePath(String name) => p.join(_tmp.path, name);

  String _assetFilePath(String name) => p.join(_path.path, name);
}
