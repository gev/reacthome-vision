import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:path/path.dart' as p;
import 'package:vision/store/lookup.dart';

typedef ReactiveAsset = ValueNotifier<String>;
typedef AssetEntry = ({Set<int> chunks, ReactiveAsset asset});

class Assets implements Lookup<String, String, ReactiveAsset> {
  final Directory _path;
  final Directory _tmp;

  final Map<String, AssetEntry> _cache = {};

  Assets({required this._path, required this._tmp}) {
    _path.createSync(recursive: true);
    _tmp.deleteSync(recursive: true);
    _tmp.createSync(recursive: true);
  }

  @override
  ReactiveAsset lookup(String name, String defaultValue) {
    var entry = _cache[name];
    if (entry == null) {
      final assetPath = _assetFilePath(name);
      final assetFile = File(assetPath);
      entry = (
        chunks: {},
        asset: ValueNotifier(assetFile.existsSync() ? assetPath : defaultValue),
      );
      _cache[name] = entry;
    }
    return entry.asset;
  }

  Future<Either<Object, bool>> complete({
    required String name,
    required int miliseconds,
    required int total,
  }) async {
    try {
      final entry = _cache[name];
      if (entry != null) {
        if (entry.chunks.length != total) {
          return Right(false);
        }
        final tmpFile = File(_tmpFilePath(name));
        if (await tmpFile.exists()) {
          final assetPath = _assetFilePath(name);
          final oldAssetFile = File(assetPath);
          if (await oldAssetFile.exists()) {
            await oldAssetFile.delete();
          }
          final assetFile = await tmpFile.rename(assetPath);
          await assetFile.setLastModified(
            DateTime.fromMillisecondsSinceEpoch(miliseconds),
          );
          entry.asset.value = assetPath;
        }
      }
    } catch (error) {
      return Left(error);
    }
    return Right(true);
  }

  Future<Object?> write({
    required String name,
    required int version,
    required int index,
    required int offset,
    required List<int> buffer,
  }) async {
    try {
      final entry = _cache[name];
      if (entry != null) {
        await File(_tmpFilePath(name))
            .open(mode: FileMode.writeOnly)
            .then((tmp) => tmp.setPosition(offset))
            .then((tmp) => tmp.writeFrom(buffer))
            .then((tmp) => tmp.close());
        entry.chunks.add(index);
      }
    } catch (error) {
      return error;
    }
    return null;
  }

  Future<Object?> start({
    required String name,
    required int version,
    required int size,
  }) async {
    try {
      final entry = _cache[name];
      if (entry != null) {
        await File(_tmpFilePath(name))
            .open(mode: FileMode.writeOnly)
            .then((tmp) => tmp.truncate(size))
            .then((tmp) => tmp.close());
        entry.chunks.clear();
      }
    } catch (error) {
      return error;
    }
    return null;
  }

  String _tmpFilePath(String name) => p.join(_tmp.path, name);

  String _assetFilePath(String name) => p.join(_path.path, name);
}
