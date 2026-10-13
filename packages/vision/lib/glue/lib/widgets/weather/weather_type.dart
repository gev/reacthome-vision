import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:glue/ir.dart';

final Ir weatherType = IrObject({
  'sunny': IrNativeValue(Value(WeatherType.sunny)),
  'sunny-night': IrNativeValue(Value(WeatherType.sunnyNight)),
  'cloudy': IrNativeValue(Value(WeatherType.cloudy)),
  'cloudy-night': IrNativeValue(Value(WeatherType.cloudyNight)),
  'light-rainy': IrNativeValue(Value(WeatherType.lightRainy)),
  'middle-rainy': IrNativeValue(Value(WeatherType.middleRainy)),
  'heavy-rainy': IrNativeValue(Value(WeatherType.heavyRainy)),
  'light-snow': IrNativeValue(Value(WeatherType.lightSnow)),
  'middle-snow': IrNativeValue(Value(WeatherType.middleSnow)),
  'heavy-snow': IrNativeValue(Value(WeatherType.heavySnow)),
  'thunder': IrNativeValue(Value(WeatherType.thunder)),
  'overcast': IrNativeValue(Value(WeatherType.overcast)),
  'foggy': IrNativeValue(Value(WeatherType.foggy)),
  'hazy': IrNativeValue(Value(WeatherType.hazy)),
  'dusty': IrNativeValue(Value(WeatherType.dusty)),
});
