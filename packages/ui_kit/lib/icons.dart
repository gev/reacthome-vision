// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';

typedef IconKind = ({IconData filled, IconData outlined});

abstract interface class IconContainer {
  IconData get add;
  IconData get delete;
  IconData get search;
  IconData get settings;
  IconData get wifi;
  IconKind get home;
}
