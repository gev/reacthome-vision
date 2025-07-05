class Connector<Id> {
  Connector({required this.id, required this.idx});

  final Id id;
  final int idx;
}

class Link<Id> {
  Link({required this.id, required this.source, required this.sink});

  final Id id;
  final Connector<Id> source;
  final Connector<Id> sink;
}
