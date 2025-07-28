import 'dart:convert';
import 'dart:io';

import 'package:flow/infrastructure/repository/memory_box_repository.dart';
import 'package:flow/infrastructure/repository/types.dart';
import 'package:utils/extensions.dart';

class JsonBoxRepositoryDto<T> {
  final MemoryBoxRepository<T> _box;
  final From<T?> _fromJson;
  final To<T> _toJson;

  const JsonBoxRepositoryDto(this._box, this._fromJson, this._toJson);

  Future<void> load(File file) async {
    final data = await file.readAsString();
    _fromJson(jsonDecode(data))?.let(_box.init);
  }

  Future<void> save(File file) async {
    final json = jsonEncode(_toJson(_box.value));
    await file.writeAsString(json);
  }
}
