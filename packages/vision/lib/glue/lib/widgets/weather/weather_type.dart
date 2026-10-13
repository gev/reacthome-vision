import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:glue/ir.dart';

final Ir weatherType = IrObject({
  'light-rainy': IrNativeValue(Value(WeatherType.lightRainy)),
  'middle-rainy': IrNativeValue(Value(WeatherType.middleRainy)),
  'heavy-rainy': IrNativeValue(Value(WeatherType.heavyRainy)),
  'light-snow': IrNativeValue(Value(WeatherType.lightSnow)),
  'middle-snow': IrNativeValue(Value(WeatherType.middleSnow)),
  'heavy-snow': IrNativeValue(Value(WeatherType.heavySnow)),
  'thunder': IrNativeValue(Value(WeatherType.thunder)),
  'sunny': IrNativeValue(Value(WeatherType.sunny)),
  'sunny-night': IrNativeValue(Value(WeatherType.sunnyNight)),
  'cloudy': IrNativeValue(Value(WeatherType.cloudy)),
  'cloudy-night': IrNativeValue(Value(WeatherType.cloudyNight)),
  'overcast': IrNativeValue(Value(WeatherType.overcast)),
  'hazy': IrNativeValue(Value(WeatherType.hazy)),
  'foggy': IrNativeValue(Value(WeatherType.foggy)),
  'dusty': IrNativeValue(Value(WeatherType.dusty)),
});
