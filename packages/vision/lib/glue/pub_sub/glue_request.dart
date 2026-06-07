import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';

import 'package:vision/pub_sub/request.dart';

class GlueRequest implements Request<String> {
  final Sink<String> _sink;

  GlueRequest(this._sink);

  static const _get = SymbolAst('get');
  static const _unsubscribe = SymbolAst('unsubscribe');

  @override
  void subscribeOne(String key) {
    _request(_one(_get, key));
  }

  @override
  void subscribeMany(Iterable<String> keys) {
    _request(_many(_get, keys));
  }

  @override
  void unsubscribeOne(String key) {
    _request(_one(_unsubscribe, key));
  }

  @override
  void unsubscribeMany(Iterable<String> keys) {
    _request(_many(_unsubscribe, keys));
  }

  ListAst _one(SymbolAst func, String key) {
    return ListAst([func, SymbolAst("'$key")]);
  }

  ListAst _many(SymbolAst func, Iterable<String> keys) {
    return ListAst(keys.map((key) => _one(func, key)).toList());
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }
}
