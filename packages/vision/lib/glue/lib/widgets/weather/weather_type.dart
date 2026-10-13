import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:glue/ir.dart';

final Ir weatherType = IrObject({
  'heavy-rainy': IrNativeValue(Value(WeatherType.heavyRainy)),
  'heavy-snow': IrNativeValue(Value(WeatherType.heavySnow)),
  'middle-snow': IrNativeValue(Value(WeatherType.middleSnow)),
  'thunder': IrNativeValue(Value(WeatherType.thunder)),
  'light-rainy': IrNativeValue(Value(WeatherType.lightRainy)),
  'light-snow': IrNativeValue(Value(WeatherType.lightSnow)),
  'sunny-night': IrNativeValue(Value(WeatherType.sunnyNight)),
  'sunny': IrNativeValue(Value(WeatherType.sunny)),
  'cloudy': IrNativeValue(Value(WeatherType.cloudy)),
  'cloudy-night': IrNativeValue(Value(WeatherType.cloudyNight)),
  'middle-rainy': IrNativeValue(Value(WeatherType.middleRainy)),
  'overcast': IrNativeValue(Value(WeatherType.overcast)),
  'hazy': IrNativeValue(Value(WeatherType.hazy)),
  'foggy': IrNativeValue(Value(WeatherType.foggy)),
  'dusty': IrNativeValue(Value(WeatherType.dusty)),
});
