// abstract interface class Scheme<Id> {
//   Iterable<Id> get items;
//   void moveItems(Iterable<Id> id, int x, int y);
// }

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:studio/core/item.dart';

class Scheme<Id> {
  Scheme({required this.id, Iterable<Item<Id>>? items}) {
    if (items != null) {
      _items = IMap.fromIterable(
        items,
        keyMapper: (it) => it.id,
        valueMapper: (it) => it,
      );
    } else {
      _items = IMap();
    }
  }

  final Id id;
  late final IMap<Id, Item<Id>> _items;

  Iterable<Item<Id>> get items => _items.values;
}
