import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:material_symbols_icons/symbols_map.dart';

Ir symbol = _symbol();

Ir roundedSymbol = _symbol('rounded');

Ir sharpSymbol = _symbol('shrap');

Ir _symbol([String? type]) => IrNativeFunc((Ir args) {
  final (name, value) = switch (args) {
    IrString(:final value) => (value, value),
    IrSymbol(:final value) => (value, value),
    IrDottedSymbol(:final parts, :final value) => (parts.join('_'), value),
    _ => (null, null),
  };
  if (name == null) {
    return throwError(wrongArgumentType(['Icon name required']));
  }
  final fullName = type != null ? '${name}_$type' : name;
  final symbol = materialSymbolsMap[fullName];
  if (symbol == null) {
    final fullValue = type != null ? '$type $value' : value;
    return throwError(wrongArgumentType(['Icon  `$fullValue` not found']));
  }
  return Eval.pure(IrNativeValue(Value(symbol)));
});
