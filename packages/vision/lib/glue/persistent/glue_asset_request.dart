import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/persistent/asset_request.dart';

class GlueAssetRequest implements AssetRequest {
  final Sink<String> _sink;

  GlueAssetRequest(this._sink);

  static const _download = SymbolAst('download');

  @override
  void one(Predicate pred) {
    _request(_one(pred));
  }

  @override
  void many(Specification spec) {
    if (spec.isNotEmpty) _request(_many(spec));
  }

  ListAst _one(Predicate pred) {
    return ListAst([_download, StringAst(pred)]);
  }

  ListAst _many(Specification spec) {
    return ListAst(spec.map(_one).toList());
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }
}
