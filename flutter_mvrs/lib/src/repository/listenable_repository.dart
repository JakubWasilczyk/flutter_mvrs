abstract class ListenableRepository<T> {
  Stream<T?> listen(String id);
  Stream<List<T>> listenList();
}
