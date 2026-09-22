import 'package:flutter/cupertino.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:vision/widgets/media/video_player.dart';

Ir mediaPlayer = IrNativeFunc(
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
    final widget = MediaPlayer(
      key: props.key,
      url: url,
      width: props.width,
      height: props.height,
      fit: props.getValue<BoxFit>('fit') ?? BoxFit.contain,
      fill: props.getColor('fill') ?? Color(0xFF000000),
      alignment: props.getValue<Alignment>('alignment') ?? Alignment.center,
      aspectRatio: props.getDouble('aspect-ratio'),
      filterQuality:
          props.getValue<FilterQuality>('filter-quality') ?? FilterQuality.low,
      // controls: props.getCallback<VideoState>('controls')?.call(runtime),
      wakelock: props.getBool('wakelock') ?? true,
      pauseUponEnteringBackgroundMode:
          props.getValue<bool>('pause-upon-entering-background-mode') ?? true,
      resumeUponEnteringForegroundMode:
          props.getValue<bool>('resume-upon-entering-foreground-mode') ?? false,
      subtitleViewConfiguration:
          props.getValue<SubtitleViewConfiguration>(
            'subtitle-view-configuration',
          ) ??
          const SubtitleViewConfiguration(),
      focusNode: props.getValue<FocusNode>('focus-node'),
      // onEnterFullscreen: props
      //     .getVoidCallback('on-enter-fullscreen')
      //     ?.call(runtime),
      // onExitFullscreen: props
      //     .getVoidCallback('on-exit-fullscreen')
      //     ?.call(runtime),
    );

    return IrNativeValue(Value(widget));
  });
}
