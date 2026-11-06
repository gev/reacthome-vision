import 'package:glue/either.dart';
import 'package:vision/persistent/db.dart';
import 'package:vision/store/revision.dart';

typedef DbDecoder<T> = Either<DbError, T> Function(String value);
typedef DbEncoder<T> = Either<DbError, String> Function(T value);

/// Adapts a string-backed database to a typed database using codecs.
class CodecDb<T> implements Db<String, T, int> {
  final Db<String, String, int> _db;
  final DbDecoder<T> _decode;
  final DbEncoder<T> _encode;

  CodecDb({required this._db, required this._decode, required this._encode});

  @override
  Future<Either<DbError, Revision<T, int>>> lookup(String key) async {
    switch (await _db.lookup(key)) {
      case Left(value: final error):
        return Left(error);
      case Right(value: final revision):
        switch (_decode(revision.payload)) {
          case Left(value: final error):
            return Left(error);
          case Right(value: final payload):
            return Right((payload: payload, version: revision.version));
        }
    }
  }

  @override
  Future<Either<DbError, Map<String, Revision<T, int>>>> selectAll() async {
    switch (await _db.selectAll()) {
      case Left(value: final error):
        return Left(error);
      case Right(value: final records):
        final decoded = <String, Revision<T, int>>{};
        for (final entry in records.entries) {
          switch (_decode(entry.value.payload)) {
            case Left(value: final error):
              return Left(DbError('${entry.key}: ${error.message}'));
            case Right(value: final payload):
              decoded[entry.key] = (
                payload: payload,
                version: entry.value.version,
              );
          }
        }
        return Right(decoded);
    }
  }

  @override
  Future<DbError?> store(String key, Revision<T, int> value) async {
    switch (_encode(value.payload)) {
      case Left(value: final error):
        return error;
      case Right(value: final payload):
        return _db.store(key, (payload: payload, version: value.version));
    }
  }
}
