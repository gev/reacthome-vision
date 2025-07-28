import 'dart:io';

import 'package:flow/common/handler.dart';
import 'package:flow/controllers/discovery/discovery_action_dto.dart';
import 'package:flow/core/home/home_api.dart';
import 'package:flow/core/meta/meta.dart';

class DiscoveryController implements Handler<Datagram> {
  final HomeApi homeApi;

  const DiscoveryController({required this.homeApi});
  @override
  void handle(Datagram datagram) {
    try {
      final action = DiscoveryActionDto.fromData(datagram.data);
      if (action != null) {
        homeApi.addHome(
          action.id,
          meta: Meta(title: action.payload.title, code: action.payload.code),
          project: action.payload.project,
          address: datagram.address,
        );
        homeApi.confirmHome(action.id);
      }
    } catch (_) {}
  }
}
