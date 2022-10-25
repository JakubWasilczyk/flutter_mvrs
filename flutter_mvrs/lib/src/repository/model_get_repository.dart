import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ModelGetRepository<T> {
  Future<DataState<T?>> get(String id);
  Future<DataState<List<T>>> getList();
}

abstract class ModelGetParamRepository<T, P> {
  Future<DataState<T?>> get(String id, P param);
  Future<DataState<List<T>>> getList(P param);
}
