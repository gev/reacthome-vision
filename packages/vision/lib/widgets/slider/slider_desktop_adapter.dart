import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SliderDesktopAdapter extends StatelessWidget {
  final Widget child; // Тот самый слайдер, что пришел от Glue
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const SliderDesktopAdapter({
    super.key,
    required this.child,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      // Обработка клавиш (Shortcuts + Actions)
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const NextIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const PrevIntent(),
      },
      actions: {
        NextIntent: CallbackAction(onInvoke: (_) => onNext()),
        PrevIntent: CallbackAction(onInvoke: (_) => onPrev()),
      },
      child: Listener(
        // Обработка колеса мыши
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            event.scrollDelta.dy > 0 ? onNext() : onPrev();
          }
        },
        child: child,
      ),
    );
  }
}

// Простые классы для намерений
class NextIntent extends Intent {
  const NextIntent();
}

class PrevIntent extends Intent {
  const PrevIntent();
}
