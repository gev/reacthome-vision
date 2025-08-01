import 'dart:io';

import 'package:common/emitter.dart';
import 'package:common/repository/map_repository.dart';
import 'package:flow/core/connection/connection.dart';
import 'package:flow/core/connection/connection_api.dart';
import 'package:flow/core/connection/connection_entity.dart';
import 'package:flow/core/connection/connection_event.dart';
import 'package:utils/extensions.dart';

abstract class ConnectionService<C extends ConnectionEntity<S>, S>
    implements ConnectionApi<S> {
  final Emitter<ConnectionEvent> eventSink;
  final MapRepository<String, C> repository;

  const ConnectionService({required this.eventSink, required this.repository});

  @override
  Connection<S> getConnectionById(String id) => _getById(id);

  @override
  void completeConnect(String id, S socket) =>
      _getById(id).completeConnect(socket).let(eventSink.emit);

  @override
  void disconnect(String id) => _getById(id).disconnect()?.let(eventSink.emit);

  @override
  void completeDisconnect(String id) =>
      _getById(id).completeDisconnect()?.let(eventSink.emit);

  @override
  void fail(String id) => _getById(id).fail()?.let(eventSink.emit);

  C _create(String id);

  C _getById(String id) {
    var connection = repository.get(id);
    if (connection == null) {
      connection = _create(id);
      repository.put(connection);
    }
    return connection;
  }
}

class LocalConnectionService<S>
    extends ConnectionService<LocalConnectionEntity<S>, S>
    implements LocalConnectionApi<S> {
  LocalConnectionService({required super.eventSink, required super.repository});

  @override
  void connect(String id, InternetAddress address) =>
      _getById(id).connect(address)?.let(eventSink.emit);

  @override
  LocalConnectionEntity<S> _create(String id) => LocalConnectionEntity(id);
}

class CloudConnectionService<S>
    extends ConnectionService<CloudConnectionEntity<S>, S>
    implements CloudConnectionApi<S> {
  CloudConnectionService({required super.eventSink, required super.repository});

  @override
  void connect(String id) => _getById(id).connect()?.let(eventSink.emit);

  @override
  CloudConnectionEntity<S> _create(String id) => CloudConnectionEntity(id);
}
