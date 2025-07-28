import 'package:flow/core/home_connection/home_connection_api.dart';
import 'package:flow/core/home_connection/home_connection_entity.dart';
import 'package:flow/core/home_connection/home_connection_service.dart';
import 'package:flow/infrastructure/repository/memory_map_repository.dart';
import 'package:flow/infrastructure/websocket/websocket.dart';
import 'package:flow/make/core/connection_factory.dart';
import 'package:flow/make/core/home_factory.dart';

class HomeConnectionFactory {
  HomeConnectionFactory._();

  static final _repository =
      MemoryMapRepository<String, HomeConnectionEntity<WebSocket>>();

  static Future<HomeConnectionApi> makeHomeConnectionApi() async =>
      HomeConnectionService<WebSocket>(
        eventSink: ConnectionFactory.connectionEventBus.sink,
        localConnectionApi: ConnectionFactory.makeLocalConnectionApi(),
        cloudConnectionApi: ConnectionFactory.makeCloudConnectionApi(),
        homeApi: await HomeFactory.makeHomeApi(),
        repository: _repository,
      );
}
