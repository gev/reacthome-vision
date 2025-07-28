import 'package:flow/controllers/reacthome/entity_controller.dart';
import 'package:flow/controllers/reacthome/home/home_action_dto.dart';
import 'package:flow/controllers/reacthome/reacthome_action.dart';
import 'package:flow/core/home/home_api.dart';
import 'package:flow/core/meta/meta.dart';
import 'package:utils/extensions.dart';

class HomeController extends EntityController {
  final HomeApi homeApi;

  HomeController({
    required super.eventSource,
    required super.controllers,
    required this.homeApi,
  });

  @override
  void executeAction(ReacthomeActionSet action) =>
      HomeActionDto.fromJSON(action.payload)?.let((payload) {
        homeApi.updateHome(
          action.id,
          meta: Meta(title: payload.title, code: payload.code),
          project: payload.project,
        );
      });
}
