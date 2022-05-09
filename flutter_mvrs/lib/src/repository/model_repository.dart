import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ModelRepository<T> {
  Future<T?> get(String id, {Filters filters});
  Future<String> save(T model);
  Future<List<T>> getList({Filters filters});
  Future<void> delete(T model);
}
