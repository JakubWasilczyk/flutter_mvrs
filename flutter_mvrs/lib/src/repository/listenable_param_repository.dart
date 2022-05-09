import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ListenableParamRepository<T, P> {
  Stream<T?> listen(String id, P params, {Filters filters});
  Stream<List<T>> listenList(P params, {Filters filters});
}
