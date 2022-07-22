import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/src/base_collection_provider.dart';

import 'filters/filter.dart';

abstract class SubCollectionProvider<T extends BaseModel> extends BaseCollectionProvider<T> {
  SubCollectionProvider(FirebaseFirestore firestore) : super(firestore);

  Future<T?> get(String parent, String id) => super.baseGet(parent, id);

  Future<T?> getWhere(String parent, List<Filter>? filters) => super.baseGetWhere(parent, filters);

  Future<List<T>> getList(String parent, {List<Filter>? filters}) => super.baseGetList(parent, filters: filters);

  Future<String> save(String parent, T model) => super.baseSave(parent, model);

  Future<void> delete(String parent, T model) => super.baseDelete(parent, model);

  Stream<T?> listen(String parent, String id) => super.baseListen(parent, id);

  Stream<T?> listenWhere(String parent, List<Filter>? filters) => super.baseListenWhere(parent, filters);

  Stream<List<T>> listenList(String parent, {List<Filter>? filters}) => super.baseListenList(parent, filters: filters);
}
