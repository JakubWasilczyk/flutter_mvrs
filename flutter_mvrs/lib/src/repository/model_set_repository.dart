abstract class ModelSetRepository<T> {
  Future<String> save(T model);
  Future<void> delete(T model);
}

abstract class ModelSetParamRepository<T, P> {
  Future<String> save(T model, P params);
  Future<void> delete(T model, P params);
}
