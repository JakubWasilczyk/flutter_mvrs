abstract class ModelRepository<T> {
  Future<T?> get(String id);
  Future<String> save(T model);
  Future<List<T>> getList();
  Future<void> delete(T model);
}
