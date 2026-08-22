import 'package:glue/either.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:vision/persistent/db.dart';
import 'package:vision/store/revision.dart';

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
      REPLACE INTO data (key, value, version)
      VALUES (?, ?, ?)
    ''');
  }

  @override
  Future<Either<DbError, Revision<String, int>>> lookup(String key) async {
    try {
      final res = _lookup.select([key]);
      if (res.isNotEmpty) {
        return Right(_toRecord(res.first));
      } else {
        return Left(DbError(db: this, message: '$key not found'));
      }
    } catch (e) {
      return Left(DbError(db: this, message: e.toString()));
    }
  }

  @override
  Future<DbError?> store(String key, Revision<String, int> value) async {
    try {
      _put.execute([key, value.payload, value.version]);
      return null;
    } catch (e) {
      return DbError(db: this, message: e.toString());
    }
  }

  Revision<String, int> _toRecord(Row row) =>
      (payload: row['value'], version: row['version']);

  void dispose() {
    _lookup.close();
    _put.close();
    _db.close();
  }
}
