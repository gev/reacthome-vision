import 'package:flutter/widgets.dart';
import 'package:studio/make/config/theme_config.dart';

class Config {
  static const theme = ThemeConfig(
    seedColor: Color.fromARGB(0xff, 0x00, 0x59, 0xff),
    iconGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(0xff, 0x00, 0x59, 0xff),
        Color.fromARGB(0xff, 0x00, 0xff, 0xb1),
      ],
    ),
  );

  static get getApplicationDocumentsDirectory => null;
}
