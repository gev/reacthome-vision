import 'package:glue/ir.dart';
import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/activity.dart';
import 'package:vision/glue/lib/widgets/app.dart';
import 'package:vision/glue/lib/widgets/back_drop.dart';
import 'package:vision/glue/lib/widgets/blur.dart';
import 'package:vision/glue/lib/widgets/canvas.dart';
import 'package:vision/glue/lib/widgets/closures.dart';
import 'package:vision/glue/lib/widgets/current_theme.dart';
import 'package:vision/glue/lib/widgets/image_color_scheme.dart';
import 'package:vision/glue/lib/widgets/image_filtered.dart';
import 'package:vision/glue/lib/widgets/layout.dart';
import 'package:vision/glue/lib/widgets/locale.dart';
import 'package:vision/glue/lib/widgets/logo.dart';
import 'package:vision/glue/lib/widgets/media/video_player.dart';
import 'package:vision/glue/lib/widgets/media_query.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';
import 'package:vision/glue/lib/widgets/seed_color_scheme.dart';
import 'package:vision/glue/lib/widgets/slider/circular_slider.dart';
import 'package:vision/glue/lib/widgets/slider/horizontal_slider.dart';
import 'package:vision/glue/lib/widgets/slider/vertical_slider.dart';
import 'package:vision/glue/lib/widgets/symbol.dart';
import 'package:vision/glue/lib/widgets/text_field.dart';
import 'package:vision/glue/lib/widgets/theme.dart';
import 'package:vision/glue/lib/widgets/weather/weather_background.dart';
import 'package:vision/glue/lib/widgets/weather/weather_type.dart';
import 'package:vision/glue/lib/widgets/with_seed_color.dart';
import 'package:vision/glue/lib/widgets/with_theme.dart';

ModuleInfo widgetsModule({required Ir image}) {
  return nativeModule('ffi.vision.widgets', [
    ('horizontal-slider', horizontalSlider),
    ('vertical-slider', verticalSlider),
    ('circular-slider', circularSlider),

    ('double-curtain', doubleCurtain),
    ('double-gate', doubleGate),
    ('left-curtain', leftCurtain),
    ('left-gate', leftGate),
    ('right-curtain', rightCurtain),
    ('right-gate', rightGate),
    ('shutter', shutter),

    ('app', app),
    ('layout', layout),
    ('locale', locale),
    ('logo', logo),

    ('symbol', symbol),
    ('sharp-symbol', sharpSymbol),
    ('rounded-symbol', roundedSymbol),

    ('image-filtered', imageFiltered),

    ('media-query', mediaQuery),

    ('current-theme', currentTheme),
    ('with-seed-color', withSeedColor),
    ('with-theme', withTheme),
    ('theme', theme),
    ('image-color-scheme', imageColorScheme),
    ('seed-color-scheme', seedColorScheme),

    ('load-image', image),

    ('activity', activity),
    ('text-field', textField),
    ('canvas', canvas),
    ('video-player', videoPlayer),

    ('backdrop', backdrop),
    ('blur', blur),
    ('placeholder', placeholder),

    ('weather-type', weatherType),
    ('weather-background', weatherBackground),
  ]);
}
