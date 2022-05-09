abstract class ModelParamRepository<T, P> {
  Future<T?> get(String id, P params);
  Future<String> save(T model, P params);
  Future<List<T>> getList(P params);
  Future<void> delete(T model, P params);
}
