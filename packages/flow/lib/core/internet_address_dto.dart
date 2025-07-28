import 'dart:io';

import 'package:utils/extensions.dart';

class InternetAddressDto {
  InternetAddressDto._();

  static InternetAddress? fromJson(String? address) =>
      address?.let(InternetAddress.new);
}
