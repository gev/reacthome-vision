import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/pub_sub/request.dart';

class GlueRequest implements Request<String> {
  final Sink<String> _sink;

  GlueRequest(this._sink);

  @override
  void one(String key) {
    _request(_one(key));
  }

  @override
  void many(Iterable<String> keys) {
    _request(_many(keys));
  }

  ListAst _one(String key) {
    return ListAst([_get, StringAst(key)]);
  }

  ListAst _many(Iterable<String> keys) {
    return ListAst([_get, ...keys.map(StringAst.new)]);
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }

  static const _get = SymbolAst('get');
}
