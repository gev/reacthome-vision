import 'package:flow/core/home/home.dart';
import 'package:flow/core/home/home_entity.dart';
import 'package:flow/core/internet_address_dto.dart';
import 'package:flow/core/meta/meta_dto.dart';

class HomeDto {
  HomeDto._();

  static HomeEntity fromJson(Map<String, dynamic> json) => HomeEntity(
    json['id'],
    MetaDto.fromJson(json['meta']),
    InternetAddressDto.fromJson(json['address']),
    json['project'],
  );

  static Map<String, dynamic> toJson(Home home) => {
    'id': home.id,
    'meta': MetaDto.toJson(home.meta),
    'address': home.address?.host,
    'project': home.project,
  };
}
