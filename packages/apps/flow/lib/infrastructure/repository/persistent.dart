import 'dart:async';
import 'dart:io';

import 'package:flow/infrastructure/repository/types.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Persistent {
  static const defaultTimeout = Duration(milliseconds: 100);

  final File _file;
  final FileHandler _fromFile;
  final FileHandler _toFile;

  late final Timer _timer;

  Persistent._(this._file, this._fromFile, this._toFile, Duration timeout) {
    _timer = Timer.periodic(timeout, (_) => _save());
  }

  static Future<Persistent> make(
    String name,
    String scope, {
    required FileHandler fromFile,
    required FileHandler toFile,
    required Duration timeout,
  }) async {
    final location = await getApplicationDocumentsDirectory();
    final directory = join(location.path, scope);
    await Directory(directory).create(recursive: true);
    final path = join(directory, name);
    final persistent = Persistent._(File(path), fromFile, toFile, timeout);
    await persistent._load();
    return persistent;
  }

  int _storeTimestamp = 0;
  int _fileTimestamp = 0;
  bool _done = true;

  bool get _shouldSave => _storeTimestamp != _fileTimestamp && _done;

  void _save() async {
    if (_shouldSave) {
      _fileTimestamp = _storeTimestamp;
      _done = false;
      await _toFile(_file);
      _done = true;
    }
  }

  Future<void> _load() async {
    try {
      await _fromFile(_file);
    } catch (_) {}
  }

  void updateTimestamp() => _storeTimestamp++;

  void dispose() {
    _timer.cancel();
    _save();
  }
}
