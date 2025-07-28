import 'package:common/bus/bus.dart';
import 'package:common/repository/box_repository.dart';
import 'package:flow/core/preferences/preferences.dart';
import 'package:flow/core/preferences/preferences_api.dart';
import 'package:flow/core/preferences/preferences_dto.dart';
import 'package:flow/core/preferences/preferences_event.dart';
import 'package:flow/core/preferences/preferences_service.dart';
import 'package:flow/infrastructure/repository/persistent_box_repository.dart';

class PreferencesFactory {
  PreferencesFactory._();

  static final eventBus = Bus<PreferencesEvent>();

  static Future<BoxRepository<Preferences>> makePreferencesBox() =>
      PersistentBoxRepository.make(
        Preferences(),
        name: 'preferences',
        scope: 'reacthome',
        fromJson: (json) => PreferencesDto.fromJson(json),
        toJson: (preferences) => PreferencesDto.toJson(preferences),
      );

  static Future<PreferencesApi> makePreferencesApi() async =>
      PreferencesService(
        eventSink: eventBus.sink,
        box: await makePreferencesBox(),
      );
}
