import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:path/path.dart' as p;
import 'package:vision/persistent/asset_request.dart';
import 'package:vision/store/lookup.dart';

typedef ReactiveAsset = ValueNotifier<String>;
typedef AssetEntry = ({Set<int> chunks, ReactiveAsset asset});

class Assets implements Lookup<String, String, ReactiveAsset> {
  final Directory _path;
  final Directory _tmp;
  final AssetRequest _request;

  final Map<String, AssetEntry> _cache = {};

  Assets({required this._path, required this._tmp, required this._request}) {
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
      if (assetFile.existsSync()) {
        entry = (chunks: {}, asset: ValueNotifier(assetPath));
      } else {
        entry = (chunks: {}, asset: ValueNotifier(defaultValue));
        _request.get(name);
      }
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

  Future<Either<Object, bool>> start({
    required String name,
    required int version,
    required int size,
  }) async {
    try {
      final entry = _cache[name];
      if (entry == null) {
        return Right(false);
      }
      final assetFile = File(_assetFilePath(name));
      if (await assetFile.exists()) {
        return Right(false);
      }
      await File(_tmpFilePath(name))
          .open(mode: FileMode.writeOnly)
          .then((tmp) => tmp.truncate(size))
          .then((tmp) => tmp.close());
      entry.chunks.clear();
    } catch (error) {
      return Left(error);
    }
    return Right(true);
  }

  String _tmpFilePath(String name) => p.join(_tmp.path, name);

  String _assetFilePath(String name) => p.join(_path.path, name);
}
