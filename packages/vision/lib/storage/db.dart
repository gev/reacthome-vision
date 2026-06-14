import 'package:glue/either.dart';

class DbError {
  final Db db;
  final String message;
  const DbError({required this.db, required this.message});
}

typedef DbRecord<K, P, V> = ({K key, P value, V version});

abstract interface class Db<K, P, V> {
  Either<DbError, Iterable<DbRecord<K, P, V>>> lookup(String key);
  DbError? store(DbRecord<K, P, V> record);
}
