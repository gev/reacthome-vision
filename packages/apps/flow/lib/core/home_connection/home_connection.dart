import 'package:common/entity.dart';
import 'package:flow/core/connection/connection.dart';

abstract interface class HomeConnection<S> implements Entity<String> {
  @override
  String get id;
  Connection<S>? get connection;
}
