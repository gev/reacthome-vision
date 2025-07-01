class Vertex<Id> {
  Vertex({required this.id, required this.idx});

  final Id id;
  final int idx;
}

class Link<Id> {
  Link({required this.id, required this.source, required this.sink});

  final Id id;
  final Vertex<Id> source;
  final Vertex<Id> sink;
}
