import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/store/lookup/fetched_lookup.dart';

const get = SymbolAst('get');

String fetchExpression(String key) {
  final expression = ListAst([get, StringAst(key)]);
  return serializeAst(expression);
}

Fetch<String> fetch(Sink<String> sink) => (String key) {
  sink.add(fetchExpression(key));
};
