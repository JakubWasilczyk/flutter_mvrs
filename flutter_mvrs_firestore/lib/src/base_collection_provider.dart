import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

import 'base_firestore.dart';
import 'filters/filter.dart' as core;
import 'filters/where.dart' as core;

abstract class BaseCollectionProvider<T extends BaseModel>
    extends BaseFirestore<T> {
  BaseCollectionProvider(FirebaseFirestore firestore) : super(firestore);

  List<core.Filter>? applyDefaultOrderBy(List<core.Filter>? filters) {
    if (!hasOrderBy) return filters;
    if (filters != null) {
      for (final filter in filters) {
        if (filter is core.OrderBy) return filters;
      }
    }
    final result = (filters ?? <core.Filter>[]);
    result.add(core.OrderBy(orderBy!, orderByDirection));
    return result;
  }

  Query<T> applyFilters(Query<T> query, List<core.Filter>? filters) {
    if (filters == null) return query;
    for (final filter in filters) {
      query = filter.apply(query);
    }
    return query;
  }

  Future<T?> baseGet(String parent, String id) =>
      doc(id, parent).get().then((v) => v.data());

  Future<T?> baseGetWhere(String parent, List<core.Filter>? filters) async {
    Query<T> query = collection(parent);
    filters?.removeWhere(
        (element) => (element is core.Limit) || (element is core.LimitLast));
    filters = applyDefaultOrderBy(filters);
    query = applyFilters(query, filters);
    query = query.limit(1);
    final docs = await query.get().then((v) => v.docs);
    return docs.isEmpty ? null : docs.first.data();
  }

  Future<List<T>> baseGetList(String parent,
      {List<core.Filter>? filters}) async {
    Query<T> query = collection(parent);
    filters = applyDefaultOrderBy(filters);
    query = applyFilters(query, filters);
    final docs = await query.get().then((v) => v.docs);
    return docs.map((e) => e.data()).toList();
  }

  Future<String> _create(String parent, T model) async {
    final ref = await collection(parent).add(model);
    return ref.id;
  }

  Future<String> _update(String parent, T model) async {
    final ref = doc(model.id, parent);
    await ref.set(model, SetOptions(merge: true));
    return ref.id;
  }

  Future<String> baseSave(String parent, T model) {
    if (model.id == null) return _create(parent, model);
    return _update(parent, model);
  }

  Future<void> baseDelete(String parent, T model) async {
    return doc(model.id, parent).delete();
  }

  Stream<T?> baseListen(String parent, String id) {
    return doc(id, parent).snapshots().map((event) => event.data());
  }

  Stream<T?> baseListenWhere(String parent, List<core.Filter>? filters) {
    Query<T> query = collection(parent);
    filters?.removeWhere(
        (element) => (element is core.Limit) || (element is core.LimitLast));
    filters = applyDefaultOrderBy(filters);
    query = applyFilters(query, filters);
    query = query.limit(1);
    return query
        .snapshots()
        .map((e) => e.size == 0 ? null : e.docs.first)
        .map((item) => item?.data());
  }

  Stream<List<T>> baseListenList(String parent, {List<core.Filter>? filters}) {
    Query<T> query = collection(parent);
    filters = applyDefaultOrderBy(filters);
    query = applyFilters(query, filters);
    return query
        .snapshots()
        .map((e) => e.docs)
        .map((list) => list.map((e) => e.data()).toList());
  }
}
