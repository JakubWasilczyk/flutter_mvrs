import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

import 'base_collection_provider.dart';
import 'filters/filter.dart' as core;

abstract class CollectionProvider<T extends BaseModel>
    extends BaseCollectionProvider<T> {
  CollectionProvider(FirebaseFirestore firestore) : super(firestore);

  Future<T?> get(String id) => super.baseGet("", id);

  Future<T?> getWhere(List<core.Filter>? filters) =>
      super.baseGetWhere("", filters);

  Future<List<T>> getList({List<core.Filter>? filters}) =>
      super.baseGetList("", filters: filters);

  Future<String> save(T model) => super.baseSave("", model);

  Future<void> delete(T model) => super.baseDelete("", model);

  Stream<T?> listen(String id) => super.baseListen("", id);

  Stream<T?> listenWhere(List<core.Filter>? filters) =>
      super.baseListenWhere("", filters);

  Stream<List<T>> listenList({List<core.Filter>? filters}) =>
      super.baseListenList("", filters: filters);
}
