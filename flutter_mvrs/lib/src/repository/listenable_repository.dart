import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ListenableRepository<T> {
  Stream<DataState<T?>> listen(String id);
  Stream<DataState<List<T>>> listenList();
}

abstract class ListenableParamRepository<T, P> {
  Stream<DataState<T?>> listen(String id, P param);
  Stream<DataState<List<T>>> listenList(P param);
}
