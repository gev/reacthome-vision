import 'package:flutter_weather_bg/utils/weather_type.dart';
import 'package:glue/ir.dart';

final Ir weatherType = IrObject({
  'heavyRainy': IrNativeValue(Value(WeatherType.heavyRainy)),
  'heavySnow': IrNativeValue(Value(WeatherType.heavySnow)),
  'middleSnow': IrNativeValue(Value(WeatherType.middleSnow)),
  'thunder': IrNativeValue(Value(WeatherType.thunder)),
  'lightRainy': IrNativeValue(Value(WeatherType.lightRainy)),
  'lightSnow': IrNativeValue(Value(WeatherType.lightSnow)),
  'sunnyNight': IrNativeValue(Value(WeatherType.sunnyNight)),
  'sunny': IrNativeValue(Value(WeatherType.sunny)),
  'cloudy': IrNativeValue(Value(WeatherType.cloudy)),
  'cloudyNight': IrNativeValue(Value(WeatherType.cloudyNight)),
  'middleRainy': IrNativeValue(Value(WeatherType.middleRainy)),
  'overcast': IrNativeValue(Value(WeatherType.overcast)),
  'hazy,': IrNativeValue(Value(WeatherType.hazy)),
  'foggy': IrNativeValue(Value(WeatherType.foggy)),
  'dusty': IrNativeValue(Value(WeatherType.dusty)),
});
