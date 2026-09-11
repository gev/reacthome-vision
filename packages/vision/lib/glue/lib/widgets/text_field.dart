import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:glue_flutter/glue_flutter.dart';

final Ir textField = IrNativeFunc(textFieldImpl);

Eval<Ir> textFieldImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createTextField(
    WidgetProperties(properties.unlock),
  ),
  _ => _createTextField(WidgetProperties.empty()),
};

Eval<Ir> _createTextField(WidgetProperties properties) {
  return getRuntime().map((runtime) {
    final widget = _GlueTextFieldWidget(
      properties: properties,
      runtime: runtime,
    );
    return IrNativeValue(Value(widget));
  });
}

class _GlueTextFieldWidget extends StatefulWidget {
  const _GlueTextFieldWidget({required this.properties, required this.runtime});

  final WidgetProperties properties;
  final Runtime runtime;

  @override
  State<_GlueTextFieldWidget> createState() => _GlueTextFieldWidgetState();
}

class _GlueTextFieldWidgetState extends State<_GlueTextFieldWidget> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    final valueArg = widget.properties.get('value');
    switch (valueArg) {
      case (IrNativeValue(value: Value(value: ValueNotifier<Ir> notifier))):
        _controller = _SyncedTextEditingController(sourceNotifier: notifier);
      default:
        final text = to<String>(valueArg);
        if (text != null) {
          _controller = TextEditingController(text: text);
        }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      groupId: widget.properties.getValue<Object>('group-id') ?? EditableText,
      focusNode: widget.properties.getValue<FocusNode>('focus-node'),
      undoController: widget.properties.getValue<UndoHistoryController>(
        'undo-controller',
      ),
      decoration: widget.properties.getValue<InputDecoration>('decoration'),
      keyboardType: widget.properties.getValue<TextInputType>('keyboard-type'),
      textInputAction: widget.properties.getValue<TextInputAction>(
        'text-input-action',
      ),
      textCapitalization:
          widget.properties.getValue<TextCapitalization>(
            'text-capitalization',
          ) ??
          TextCapitalization.none,
      style: widget.properties.getValue<TextStyle>('style'),
      strutStyle: widget.properties.getValue<StrutStyle>('strut-style'),
      textAlign:
          widget.properties.getValue<TextAlign>('text-align') ??
          TextAlign.start,
      textAlignVertical: widget.properties.getValue<TextAlignVertical>(
        'text-align-vertical',
      ),
      textDirection: widget.properties.getValue<TextDirection>(
        'text-direction',
      ),
      readOnly: widget.properties.getBool('read-only') ?? false,
      showCursor: widget.properties.getBool('show-cursor'),
      autofocus: widget.properties.getBool('autofocus') ?? false,
      statesController: widget.properties.getValue<WidgetStatesController>(
        'states-controller',
      ),
      obscuringCharacter:
          widget.properties.getString('obscuring-character') ?? '•',
      obscureText: widget.properties.getBool('obscure-text') ?? false,
      autocorrect: widget.properties.getBool('autocorrect') ?? true,
      smartDashesType: widget.properties.getValue<SmartDashesType>(
        'smart-dashes-type',
      ),
      smartQuotesType: widget.properties.getValue<SmartQuotesType>(
        'smart-quotes-type',
      ),
      enableSuggestions:
          widget.properties.getBool('enable-suggestions') ?? true,
      maxLines: widget.properties.getInt('max-lines') ?? 1,
      minLines: widget.properties.getInt('min-lines'),
      expands: widget.properties.getBool('expands') ?? false,
      maxLength: widget.properties.getInt('max-length'),
      maxLengthEnforcement: widget.properties.getValue<MaxLengthEnforcement>(
        'max-length-enforcement',
      ),
      onChanged: widget.properties
          .getCallback<String>('on-changed')
          ?.call(widget.runtime),
      onEditingComplete: widget.properties
          .getVoidCallback('on-editing-complete')
          ?.call(widget.runtime),
      onSubmitted: widget.properties
          .getCallback<String>('on-submitted')
          ?.call(widget.runtime),
      inputFormatters: widget.properties.getValue<List<TextInputFormatter>>(
        'input-formatters',
      ),
      enabled: widget.properties.getBool('enabled') ?? true,
      ignorePointers: widget.properties.getBool('ignore-pointers'),
      cursorWidth: widget.properties.getDouble('cursor-width') ?? 2.0,
      cursorHeight: widget.properties.getDouble('cursor-height') ?? 16.0,
      cursorRadius: widget.properties.getValue<Radius>('cursor-radius'),
      cursorOpacityAnimates: widget.properties.getBool(
        'cursor-opacity-animates',
      ),
      cursorColor: widget.properties.getColor('cursor-color'),
      cursorErrorColor: widget.properties.getColor('cursor-error-color'),
      selectionHeightStyle: widget.properties.getValue<BoxHeightStyle>(
        'selection-height-style',
      ),
      selectionWidthStyle: widget.properties.getValue<BoxWidthStyle>(
        'selection-width-style',
      ),
      keyboardAppearance: widget.properties.getValue<Brightness>(
        'keyboard-appearance',
      ),
      scrollPadding:
          widget.properties.getValue<EdgeInsets>('scroll-padding') ??
          const EdgeInsets.all(20.0),
      dragStartBehavior:
          widget.properties.getValue<DragStartBehavior>(
            'drag-start-behavior',
          ) ??
          DragStartBehavior.start,
      enableInteractiveSelection:
          widget.properties.getBool('enable-interactive-selection') ?? true,
      selectAllOnFocus:
          widget.properties.getBool('select-all-on-focus') ?? false,
      selectionControls: widget.properties.getValue<TextSelectionControls>(
        'selection-controls',
      ),
      onTap: widget.properties.getVoidCallback('on-tap')?.call(widget.runtime),
      onTapAlwaysCalled:
          widget.properties.getBool('on-tap-always-called') ?? false,
      onTapOutside: widget.properties
          .getCallback<PointerDownEvent>('on-tap-outside')
          ?.call(widget.runtime),
      onTapUpOutside: widget.properties
          .getCallback<PointerUpEvent>('on-tap-up-outside')
          ?.call(widget.runtime),
      mouseCursor: widget.properties.getValue<MouseCursor>('mouse-cursor'),
      scrollController: widget.properties.getValue<ScrollController>(
        'scroll-controller',
      ),
      scrollPhysics: widget.properties.getValue<ScrollPhysics>(
        'scroll-physics',
      ),
      autofillHints: widget.properties.getValue<List<String>>('autofill-hints'),
      contentInsertionConfiguration: widget.properties
          .getValue<ContentInsertionConfiguration>(
            'content-insertion-configuration',
          ),
      clipBehavior:
          widget.properties.getValue<Clip>('clip-behavior') ?? Clip.hardEdge,
      restorationId: widget.properties.getString('restoration-id'),
      stylusHandwritingEnabled:
          widget.properties.getBool('stylus-handwriting-enabled') ?? true,
      enableIMEPersonalizedLearning:
          widget.properties.getBool('enable-ime-personalized-learning') ?? true,
      canRequestFocus: widget.properties.getBool('can-request-focus') ?? true,
      spellCheckConfiguration: widget.properties
          .getValue<SpellCheckConfiguration>('spell-check-configuration'),
      magnifierConfiguration: widget.properties
          .getValue<TextMagnifierConfiguration>('magnifier-configuration'),
      hintLocales: widget.properties.getValue<List<Locale>>('hint-locales'),
    );
  }
}

class _SyncedTextEditingController extends TextEditingController {
  final ValueNotifier<Ir> _sourceNotifier;

  _SyncedTextEditingController({required this._sourceNotifier})
    : super(text: to<String>(_sourceNotifier.value)) {
    _sourceNotifier.addListener(_handleStateChange);
  }

  void _handleStateChange() {
    final newStateValue = _sourceNotifier.value;
    final newText = to<String>(newStateValue) ?? "";

    if (text != newText) {
      final currentSelection = selection;
      text = newText;
      try {
        selection = currentSelection.copyWith(
          baseOffset: currentSelection.baseOffset.clamp(0, newText.length),
          extentOffset: currentSelection.extentOffset.clamp(0, newText.length),
        );
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _sourceNotifier.removeListener(_handleStateChange);
    super.dispose();
  }
}
