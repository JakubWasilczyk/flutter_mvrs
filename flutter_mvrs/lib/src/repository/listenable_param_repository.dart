abstract class ListenableParamRepository<T, P> {
  Stream<T?> listen(String id, P params);
  Stream<List<T>> listenList(P params);
}
