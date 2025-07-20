import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:studio/core/item.dart';
import 'package:studio/core/link.dart';

class Scheme<Id> {
  Scheme({
    required this.id,
    Iterable<Item<Id>>? items,
    Iterable<Link<Id>>? links,
  }) {
    _items = IList(items);
    _links = IList(links);
  }

  final Id id;
  late final IList<Item<Id>> _items;
  late final IList<Link<Id>> _links;

  Iterable<Item<Id>> get items => _items;
  Iterable<Link<Id>> get links => _links;
}
