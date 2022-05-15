abstract class ListenableRepository<T> {
  Stream<T?> listen(String id);
  Stream<List<T>> listenList({int? limit});
}

abstract class ListenableParamRepository<T, P> {
  Stream<T?> listen(String id, P params);
  Stream<List<T>> listenList(P params, {int? limit});
}
