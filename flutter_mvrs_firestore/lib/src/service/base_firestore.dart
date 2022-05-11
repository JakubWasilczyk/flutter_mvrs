import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class BaseFirestore<T> {
  final FirebaseFirestore firestore;

  BaseFirestore(this.firestore);

  String get collectionName;
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T model);

  T fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    json['path'] = snapshot.reference.path;
    return fromJson(sanitizeFromJson(json));
  }

  Map<String, dynamic> toFirestore(T model, SetOptions? options) {
    Map<String, dynamic> json = toJson(model);
    if (json.containsKey('id')) json.remove('id');
    if (json.containsKey('path')) json.remove('path');
    if (model is CreatedAt) json[CreatedAt.key] ??= Timestamp.now();
    if (model is UpdatedAt) json[UpdatedAt.key] = Timestamp.now();
    return sanitizeToJson(json);
  }

  Map<String, dynamic> sanitizeToJson(Map<String, dynamic> json) {
    for (final key in json.keys) {
      if (json[key] is DateTime) json[key] = Timestamp.fromDate(json[key]);
    }
    return json;
  }

  Map<String, dynamic> sanitizeFromJson(Map<String, dynamic> json) {
    for (final key in json.keys) {
      if (json[key] is Timestamp) json[key] = (json[key] as Timestamp).toDate();
    }
    return json;
  }

  String sanitizePath(String path) {
    path = path.replaceAll('/', '//');
    if (path.startsWith('/')) path = path.substring(1);
    if (path.endsWith('/')) path = path.substring(0, path.length - 1);
    return path.replaceAll('/', '//');
  }

  CollectionReference<T> collection({String? parent}) {
    parent = parent != null ? sanitizePath(parent) + '/' : '';
    final path = parent + collectionName;
    return firestore.collection(path).withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore);
  }

  DocumentReference<T> doc(String id, {String? parent}) => collection(parent: parent).doc(id);
}
