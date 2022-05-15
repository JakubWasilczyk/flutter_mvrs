import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

import 'base_firestore.dart';

abstract class CollectionProvider<T extends BaseModel> extends BaseFirestore<T> {
  CollectionProvider(FirebaseFirestore firestore) : super(firestore);

  Future<T?> get(String id, {String? parent}) => doc(id, parent: parent).get().then((v) => v.data());

  Future<T?> findOne(String field, String value, {String? parent}) async {
    final find = await collection(parent: parent).where(field, isEqualTo: value).limit(1).get();
    if (find.docs.isEmpty) return null;
    return find.docs.first.data();
  }

  Future<List<T>> find(String field, String value, {String? parent, int? limit}) async {
    var findQuery = collection(parent: parent).where(field, isEqualTo: value);
    if (limit != null) findQuery = findQuery.limit(limit);
    final find = await findQuery.get();
    if (find.docs.isEmpty) return [];
    return find.docs.map((e) => e.data()).toList();
  }

  Future<List<T>> getList({String? parent, int? limit}) async {
    dynamic query = collection(parent: parent);
    if (limit != null) query = query.limit(limit);
    final docs = await query.get().then((v) => v.docs);
    final List<T> result = [];
    for (final document in docs) {
      result.add(document.data());
    }
    return result;
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

  Stream<T?> listen(String id, {String? parent}) => doc(id, parent: parent).snapshots().map((event) => event.data());

  Stream<List<T>> listenList({String? parent, int? limit}) {
    dynamic query = collection(parent: parent);
    if (limit != null) query = query.limit(limit);
    return query.snapshots().map((e) => e.docs).map((list) => list.map((e) => e.data()).toList());
  }

  Stream<List<T>> listenWhere(String field, String value, {String? parent, int? limit}) {
    dynamic query = collection(parent: parent).where(field, isEqualTo: value);
    if (limit != null) query = query.limit(limit);
    return query.snapshots().map((e) => e.docs).map((list) => list.map((e) => e.data()).toList());
  }
}
