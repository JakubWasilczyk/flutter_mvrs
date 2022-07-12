import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

import 'base_firestore.dart';
import 'filters/filter.dart';

abstract class CollectionProvider<T extends BaseModel> extends BaseFirestore<T> {
  CollectionProvider(FirebaseFirestore firestore) : super(firestore);

  Query<T> applyFilters(Query<T> query, List<Filter> filters) {
    for (final filter in filters) {
      query = filter.apply(query);
    }
    return query;
  }

  Future<T?> get(String id, {String? parent}) {
    return doc(id, parent: parent).get().then((v) => v.data());
  }

  Future<List<T>> getList({String? parent, List<Filter>? filters}) async {
    Query<T> query = collection(parent: parent);
    if (filters != null) query = applyFilters(query, filters);
    if (hasOrderBy) query = query.orderBy(orderBy!, descending: orderByDescending);
    final docs = await query.get().then((v) => v.docs);
    return docs.map((e) => e.data()).toList();
  }

  Future<String> _create(T model, {String? parent}) async {
    final ref = await collection(parent: parent).add(model);
    return ref.id;
  }

  Future<String> _update(T model, {String? parent}) async {
    final ref = doc(model.id!, parent: parent);
    await ref.set(model, SetOptions(merge: true));
    return ref.id;
  }

  Future<String> save(T model, {String? parent}) {
    if (model.id == null) return _create(model, parent: parent);
    return _update(model, parent: parent);
  }

  Future<void> delete(T model, {String? parent}) async {
    if (model.id == null) return;
    return doc(model.id!, parent: parent).delete();
  }

  Stream<T?> listen(String id, {String? parent, List<Filter>? filters}) {
    return doc(id, parent: parent).snapshots().map((event) => event.data());
  }

  Stream<List<T>> listenList({String? parent, List<Filter>? filters}) {
    Query<T> query = collection(parent: parent);
    if (filters != null) query = applyFilters(query, filters);
    if (hasOrderBy) query = query.orderBy(orderBy!, descending: orderByDescending);
    return query.snapshots().map((e) => e.docs).map((list) => list.map((e) => e.data()).toList());
  }
}
