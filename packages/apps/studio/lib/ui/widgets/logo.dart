import 'package:assets/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

Widget logo({double? width, double? height}) =>
    SvgPicture.asset(Assets.logoRound, width: width, height: height);
