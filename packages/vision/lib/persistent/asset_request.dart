typedef Predicate = String;
typedef Specification = Iterable<Predicate>;

abstract interface class AssetRequest {
  void one(Predicate prd);
  void many(Specification spec);
}
