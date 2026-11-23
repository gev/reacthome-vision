import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter_ui/utils/widget_properties.dart';
import 'package:vision/widgets/media/webrtc/webrtc_ice_server.dart';

final Ir iceServer = IrNativeFunc(_createIceServer);

Eval<Ir> _createIceServer(Ir props) {
  final properties = WidgetProperties(props);
  final urls = _urls(properties.get('urls'));
  if (urls == null) {
    return throwError(
      wrongArgumentType([
        '`ice-server` requires a non-empty `urls` string or list',
      ]),
    );
  }

  final username = _optionalString(properties, 'username');
  if (username.error != null) return throwError(username.error!);
  final credential = _optionalString(properties, 'credential');
  if (credential.error != null) return throwError(credential.error!);
  if ((username.value == null) != (credential.value == null)) {
    return throwError(
      wrongArgumentType([
        '`ice-server` requires both `username` and `credential`',
      ]),
    );
  }

  return Eval.pure(
    IrNativeValue(
      Value(
        WebRtcIceServer(
          urls: urls,
          username: username.value,
          credential: credential.value,
        ),
      ),
    ),
  );
}

List<String>? _urls(Ir? value) => switch (value) {
  IrString(:final value) when value.isNotEmpty => [value],
  IrList(:final elements) => _urlList(elements.unlock),
  _ => null,
};

List<String>? _urlList(Iterable<Ir> elements) {
  final urls = <String>[];
  for (final element in elements) {
    switch (element) {
      case IrString(:final value) when value.isNotEmpty:
        urls.add(value);
      default:
        return null;
    }
  }
  return urls.isEmpty ? null : urls;
}

({String? value, RuntimeException? error}) _optionalString(
  WidgetProperties properties,
  String name,
) {
  final ir = properties.get(name);
  if (ir == null) return (value: null, error: null);
  if (ir case IrString(:final value)) return (value: value, error: null);
  return (
    value: null,
    error: wrongArgumentType([
      '`ice-server` property `$name` must be a string',
    ]),
  );
}
