import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/media/video_player_pi.dart';

Ir mediaPlayerPi = IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createMediaPlayer(
      WidgetProperties(properties.unlock),
    ),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createMediaPlayer(WidgetProperties props) {
  final url = props.getString('url');
  if (url == null) {
    return throwError(
      wrongArgumentType(['Property `url` required for media player']),
    );
  }

  return getRuntime().map((runtime) {
    final widget = MediaPlayerPi(key: props.key, url: url);

    return IrNativeValue(Value(widget));
  });
}
