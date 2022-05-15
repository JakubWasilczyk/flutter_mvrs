abstract class ModelGetRepository<T> {
  Future<T?> get(String id, {int? limit});
  Future<List<T>> getList({int? limit});
}

abstract class ModelGetParamRepository<T, P> {
  Future<T?> get(String id, P params, {int? limit});
  Future<List<T>> getList(P params, {int? limit});
}
