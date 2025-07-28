import 'package:flow/common/bus/bus.dart';
import 'package:flow/common/entity_event.dart';
import 'package:flow/common/repository/map_repository.dart';
import 'package:flow/core/home/home_api.dart';
import 'package:flow/core/home/home_dto.dart';
import 'package:flow/core/home/home_entity.dart';
import 'package:flow/core/home/home_event.dart';
import 'package:flow/core/home/home_service.dart';
import 'package:flow/infrastructure/repository/cached_map_repository.dart';
import 'package:flow/infrastructure/repository/persistent_map_repository.dart';

class HomeFactory {
  HomeFactory._();

  static final entityEventBus = Bus<EntityEvent>();
  static final homeEventBus = Bus<HomeEvent>();

  static Future<MapRepository<String, HomeEntity>> makeHomeRepository() async =>
      CachedMapRepository(
        repository: await PersistentMapRepository.make(
          name: 'home',
          scope: 'reacthome',
          fromJson: (json) => HomeDto.fromJson(json),
          toJson: (entity) => HomeDto.toJson(entity),
        ),
        eventSink: entityEventBus.sink,
      );

  static Future<HomeApi> makeHomeApi() async => HomeService(
    eventSink: homeEventBus.sink,
    repository: await makeHomeRepository(),
  );
}
