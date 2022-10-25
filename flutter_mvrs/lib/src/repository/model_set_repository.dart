import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ModelSetRepository<T> {
  Future<DataState<String>> save(T model);
  Future<DataState<void>> delete(T model);
}

abstract class ModelSetParamRepository<T, P> {
  Future<DataState<String>> save(T model, P param);
  Future<DataState<void>> delete(T model, P param);
}
