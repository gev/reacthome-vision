class Link<Id> {
  Link({required this.id, required this.source, required this.sink});

  final Id id;
  final Id source;
  final Id sink;
}
