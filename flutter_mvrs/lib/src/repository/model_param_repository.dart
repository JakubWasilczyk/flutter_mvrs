import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ModelParamRepository<T, P> {
  Future<T?> get(String id, P params, {Filters filters});
  Future<String> save(T model, P params);
  Future<List<T>> getList(P params, {Filters filters});
  Future<void> delete(T model, P params);
}
