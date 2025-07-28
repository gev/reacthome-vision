import 'package:common/handler.dart';
import 'package:flow/controllers/reacthome/reacthome_action.dart';
import 'package:flow/controllers/reacthome/reacthome_action_dto.dart';
import 'package:flow/controllers/reacthome/reacthome_controller.dart';

class ReacthomeInboundController implements Handler<String> {
  final Map<String, ReacthomeController> controllers;

  const ReacthomeInboundController(this.controllers);

  @override
  void handle(String event) {
    final action = ReacthomeActionDto.fromString(event);
    switch (action) {
      case ReacthomeActionSet e:
        controllers[e.id]?.executeAction(e);
      default:
    }
  }
}
