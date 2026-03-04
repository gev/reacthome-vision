import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/store/lookup/fetched_lookup.dart';
import 'package:vision/store/pool.dart';

const get = SymbolAst('get');

String fetchExpression(String key) {
  final expression = ListAst([get, StringAst(key)]);
  return serializeAst(expression);
}

Fetch<String> fetch(Sink<String> sink, Pool<String> pool) => (String key) {
  final expression = fetchExpression(key);
  pool.add(expression);
  sink.add(expression);
};
