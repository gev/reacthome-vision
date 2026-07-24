import 'dart:io';

import 'package:glue/compile.dart';
import 'package:glue/decompile.dart';
import 'package:glue/either.dart';
import 'package:glue/ir.dart';
import 'package:glue/parse.dart';
import 'package:glue/serialize.dart';
import 'package:path/path.dart' as p;
import 'package:vision/logger.dart';
import 'package:vision/persistent/db.dart';
import 'package:vision/persistent/raw_db.dart';
import 'package:vision/store/revision.dart';

class GlueDb implements Db<String, Ir, int> {
  late final RawDb _db;

  GlueDb({required String path}) {
    _db = RawDb(path: path);
  }

  @override
  Either<DbError, Revision<Ir, int>> lookup(String key) {
    switch (_db.lookup(key)) {
      case Left(value: final error):
        return Left(error);
      case Right(:final value):
        switch (parseGlue(value.payload)) {
          case Left(value: final error):
            return Left(DbError(db: this, message: error.toString()));
          case (Right(value: final ast)):
            final ir = compile(ast);
            return Right((payload: ir, version: value.version));
        }
    }
  }

  @override
  DbError? store(String key, Revision<Ir, int> value) {
    switch (decompile(value.payload)) {
      case Left(value: final error):
        return DbError(db: this, message: error);
      case Right(value: final ast):
        final raw = serializeAst(ast);
        return _db.store(key, (payload: raw, version: value.version));
    }
  }

  void dispose() {
    _db.dispose();
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
