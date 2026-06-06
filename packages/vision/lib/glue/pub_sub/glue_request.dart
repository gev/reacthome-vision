import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';

import 'package:vision/pub_sub/request.dart';

class GlueRequest extends _Request {
  GlueRequest(super.sink);

  @override
  SymbolAst get _func => const SymbolAst('get');
}

class ModuleRequest extends _Request {
  ModuleRequest(super.sink);

  @override
  SymbolAst get _func => const SymbolAst('load');
}

abstract class _Request implements SubscribeRequest<String> {
  final Sink<String> _sink;

  const _Request(this._sink);

  SymbolAst get _func;

  @override
  void subscribeOne(String key) {
    _request(_one(key));
  }

  @override
  void subscribeMany(Iterable<String> keys) {
    _request(_many(keys));
  }

  ListAst _one(String key) {
    return ListAst([_func, SymbolAst("'$key")]);
  }

  ListAst _many(Iterable<String> keys) {
    return ListAst(keys.map(_one).toList());
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }
}
