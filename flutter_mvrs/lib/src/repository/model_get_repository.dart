abstract class ModelGetRepository<T> {
  Future<T?> get(String id);
  Future<List<T>> getList({int? limit});
}

abstract class ModelGetParamRepository<T, P> {
  Future<T?> get(String id, P params);
  Future<List<T>> getList(P params, {int? limit});
}
