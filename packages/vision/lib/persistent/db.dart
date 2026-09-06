import 'package:glue/either.dart';
import 'package:vision/store/revision.dart';

class DbError {
  final String message;
  const DbError(this.message);

  @override
  String toString() => 'Databasee error: $message';
}

abstract interface class Db<K, T, V> {
  Future<Either<DbError, Revision<T, V>>> lookup(String key);
  Future<DbError?> store(K key, Revision<T, V> value);
}
