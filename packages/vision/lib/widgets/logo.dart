import 'package:assets/assets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  final double? width;
  final double? height;

  const Logo({this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(Assets.logoRound, width: width, height: height);
  }
}
