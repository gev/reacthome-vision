import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_bg/bg/weather_bg.dart';
import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir weatherBackground = IrNativeFunc(weatherBackgroundImpl);

Eval<Ir> weatherBackgroundImpl(Ir props) {
  switch (props) {
    case IrObject(:final properties):
      final key = properties['key'];
      final width = toDouble(properties['width']);
      if (width == null) {
        return throwError(
          wrongArgumentType(['Double property `width` required']),
        );
      }
      final height = toDouble(properties['height']);
      if (height == null) {
        return throwError(
          wrongArgumentType(['Double property `height` required']),
        );
      }
      final weatherType = to<WeatherType>(properties['weather-type']);
      if (weatherType == null) {
        return throwError(
          wrongArgumentType(['WeatherType property `weather-type` required']),
        );
      }
      return Eval.pure(
        IrNativeValue(
          Value(
            WeatherBg(
              key: key != null ? ValueKey(key) : null,
              width: width,
              height: height,
              weatherType: weatherType,
            ),
          ),
        ),
      );
    default:
      return throwError(wrongArgumentType(['object']));
  }
}
