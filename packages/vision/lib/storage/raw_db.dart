import 'package:glue/either.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:vision/storage/db.dart';

class RawDb implements Db<String, String, int> {
  late final Database _db;
  late final PreparedStatement _lookup;
  late final PreparedStatement _put;

  RawDb({required String path}) {
    _db = sqlite3.open(path);

    _db.execute('''
      CREATE TABLE IF NOT EXISTS data (
        key TEXT NOT NULL PRIMARY KEY,
        value TEXT NOT NULL,
        version INTEGER NOT NULL
        );
      ''');

    _lookup = _db.prepare('''
      SELECT key, value, version
      FROM data WHERE key = ?
    ''');

    _put = _db.prepare('''
      REPLACE INTO data (key, value, versio)
      VALUES (?, ?, ?)
    ''');
  }

  @override
  Either<DbError, Iterable<DbRecord<String, String, int>>> lookup(String key) {
    try {
      final res = _lookup.select([key]);
      return Right(res.toList().map(_toRecord));
    } catch (e) {
      return Left(DbError(db: this, message: e.toString()));
    }
  }

  @override
  DbError? store(DbRecord<String, String, int> record) {
    try {
      _put.execute([record.key, record.value, record.version]);
      return null;
    } catch (e) {
      return DbError(db: this, message: e.toString());
    }
  }

  DbRecord<String, String, int> _toRecord(Row row) =>
      (key: row['key'], value: row['value'], version: row['version']);

  void dispose() {
    _lookup.close();
    _put.close();
    _db.close();
  }
}
