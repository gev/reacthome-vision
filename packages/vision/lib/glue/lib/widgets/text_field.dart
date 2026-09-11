import 'package:flutter/material.dart';
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
      key: widget.properties.key,
      controller: _controller,
      focusNode: widget.properties.getValue<FocusNode>('focus-node'),
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
      textAlign:
          widget.properties.getValue<TextAlign>('text-align') ??
          TextAlign.start,
      readOnly: widget.properties.getBool('read-only') ?? false,
      autofocus: widget.properties.getBool('autofocus') ?? false,
      obscureText: widget.properties.getBool('obscure-text') ?? false,
      maxLines: widget.properties.getInt('max-lines') ?? 1,
      minLines: widget.properties.getInt('min-lines'),
      expands: widget.properties.getBool('expands') ?? false,
      maxLength: widget.properties.getInt('max-length'),
      enabled: widget.properties.getBool('enabled') ?? true,
      onChanged: widget.properties
          .getCallback<String>('on-changed')
          ?.call(widget.runtime),
      onSubmitted: widget.properties
          .getCallback<String>('on-submitted')
          ?.call(widget.runtime),
      onTap: widget.properties.getVoidCallback('on-tap')?.call(widget.runtime),
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
