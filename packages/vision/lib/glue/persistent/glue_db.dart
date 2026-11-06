import 'dart:io';

import 'package:glue/compile.dart';
import 'package:glue/decompile.dart';
import 'package:glue/either.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';
import 'package:glue/serialize.dart';
import 'package:path/path.dart' as p;
import 'package:vision/logger.dart';
import 'package:vision/persistent/codec_db.dart';
import 'package:vision/persistent/db.dart';
import 'package:vision/persistent/raw_db.dart';
import 'package:vision/store/revision.dart';

class GlueDb implements Db<String, Ir, int> {
  late final RawDb _rawDb;
  late final CodecDb<Ir> _db;

  GlueDb({required String path}) {
    _rawDb = RawDb(path: path);
    _db = CodecDb<Ir>(
      db: _rawDb,
      decode: _decodeGlue,
      encode: _encodeGlue,
    );
  }

  @override
  Future<Either<DbError, Revision<Ir, int>>> lookup(String key) =>
      _db.lookup(key);

  @override
  Future<Either<DbError, Map<String, Revision<Ir, int>>>> selectAll() =>
      _db.selectAll();

  @override
  Future<DbError?> store(String key, Revision<Ir, int> value) =>
      _db.store(key, value);

  void dispose() {
    _rawDb.dispose();
  }
}

Either<DbError, Ir> _decodeGlue(String source) {
  switch (parseGlue(source)) {
    case Left(value: final error):
      return Left(DbError(error.toString()));
    case Right(value: final ast):
      return Right(compile(ast));
  }
}

Either<DbError, String> _encodeGlue(Ir ir) {
  switch (decompile(ir)) {
    case Left(value: final error):
      return Left(DbError(error));
    case Right(value: final ast):
      return Right(serializeAst(ast));
  }
}

GlueDb? makeCodeDb(Directory path, Logger log) => makeGlueDb('code', path, log);

GlueDb? makeGlueDb(String name, Directory path, Logger log) {
  try {
    final dbPath = p.setExtension(p.join(path.path, name), '.db');
    return GlueDb(path: dbPath);
  } catch (error) {
    log.error(error);
    return null;
  }
}
