import 'dart:ui';

enum ItemType { dummy }

class Item<Id> {
  const Item({required this.id, required this.offset});

  final Id id;
  final Offset offset;

  Item<Id> moveTo(Offset position) => Item(id: id, offset: position);
}
